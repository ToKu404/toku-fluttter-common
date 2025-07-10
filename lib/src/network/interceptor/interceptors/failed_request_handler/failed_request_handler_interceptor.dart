part of failed_request_handler_interceptor;

@singleton
class FailedRequestHandlerInterceptor extends Interceptor {
  FailedRequestHandlerInterceptor(this._registry);

  final FailedRequestHandlerRegistry _registry;

  @override
  Future<Result<HttpResponse>> intercept(InterceptorChain chain) async {
    final endpoint = chain.endpoint;
    Result<HttpResponse> result;
    _FailedRequestResolverLock? lock;
    _FailedRequestResolverAction? action;
    Exception? errorReplacement;
    do {
      result = await chain.proceed(chain.request);
      if (action == _FailedRequestResolverAction.retryOnce) break;

      final (act, error) = await result.when<FutureOr<_FailedRequestResolverResult>>(
        success: (_) {
          lock = null;
          return (_FailedRequestResolverAction.release, null);
        },
        error: (Exception error) {
          final runningLock = _findRunningLock(endpoint, error) ??
              _findHandlerThenLock(
                endpoint,
                chain.request,
                error,
              );
          if (runningLock == null) {
            lock = null;
            return (_FailedRequestResolverAction.release, null);
          }
          lock = runningLock;
          return runningLock.future;
        },
      );
      action = act;
      errorReplacement = error;
    } while (action == _FailedRequestResolverAction.retry || action == _FailedRequestResolverAction.retryOnce);

    return result.mapError((error) => errorReplacement ?? lock?.handler.transformError(error) ?? error);
  }

  final List<_FailedRequestResolverLock> _locks = <_FailedRequestResolverLock>[];

  _FailedRequestResolverLock? _findRunningLock(HttpEndpointBase<dynamic> endpoint, Exception error) {
    final lock = _locks.firstWhereOrNull((_FailedRequestResolverLock lock) => lock.isFor(endpoint, error));
    return lock;
  }

  _FailedRequestResolverLock? _findHandlerThenLock(
    HttpEndpointBase<dynamic> endpoint,
    BaseRequest request,
    Exception error,
  ) {
    final handler =
        _registry._handlers.firstWhereOrNull((FailedRequestHandler handler) => handler.canHandle(endpoint, error));
    if (handler == null) return null;

    final resolver = _FailedRequestResolver(request, error);
    final lock = _createLock(handler, resolver);
    handler.onHandle(resolver);
    return lock;
  }

  _FailedRequestResolverLock _createLock(FailedRequestHandler handler, _FailedRequestResolver resolver) {
    final lock = _FailedRequestResolverLock(handler, resolver);
    _locks.add(lock);
    handler._currentResolver = resolver;
    resolver._completer.future.whenComplete(() {
      _locks.remove(lock);
      handler._currentResolver = null;
    });
    return lock;
  }
}

class _FailedRequestResolverLock {
  _FailedRequestResolverLock(this.handler, this.resolver);

  final FailedRequestHandler handler;
  final _FailedRequestResolver resolver;

  Future<_FailedRequestResolverResult> get future => resolver._completer.future;

  bool isFor(HttpEndpointBase<dynamic> endpoint, Exception error) =>
      !resolver._completer.isCompleted && handler.canHandle(endpoint, error);
}

typedef _FailedRequestResolverResult = (_FailedRequestResolverAction, Exception?);

enum _FailedRequestResolverAction {
  retry,
  retryOnce,
  release,
}

class _FailedRequestResolver implements FailedRequestResolver {
  _FailedRequestResolver(this.request, this.error);

  @override
  final BaseRequest request;

  @override
  final Exception error;

  final Completer<_FailedRequestResolverResult> _completer = Completer.sync();

  @override
  void retry() {
    if (_completer.isCompleted) return;
    _completer.complete((_FailedRequestResolverAction.retry, null));
  }

  @override
  void retryOnce() {
    if (_completer.isCompleted) return;
    _completer.complete((_FailedRequestResolverAction.retryOnce, null));
  }

  @override
  void release() {
    if (_completer.isCompleted) return;
    _completer.complete((_FailedRequestResolverAction.release, null));
  }

  @override
  void releaseAndReplaceError(Exception error) {
    if (_completer.isCompleted) return;
    _completer.complete((_FailedRequestResolverAction.release, error));
  }
}
