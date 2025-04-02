part of failed_request_handler_interceptor;

@singleton
class FailedRequestHandlerInterceptor extends Interceptor {
  FailedRequestHandlerInterceptor(this._registry, this._authTokenInterceptor);

  final FailedRequestHandlerRegistry _registry;
  final AuthTokenInterceptor _authTokenInterceptor;

  @override
  Future<Result<HttpResponse>> intercept(InterceptorChain chain) async {
    debugPrint('--- Intercept started for endpoint: ${chain.endpoint} ---');

    final endpoint = chain.endpoint;
    Result<HttpResponse> result;
    _FailedRequestResolverLock? lock;
    _FailedRequestResolverAction? action;
    Exception? errorReplacement;

    do {
      // Pastikan token terbaru sebelum mengirim ulang permintaan
      if (chain.endpoint.authType == AuthType.session) {
        chain.request.headers['Authorization'] = 'Bearer ${_authTokenInterceptor.accessToken}';
      }

      debugPrint('Sending request...');
      result = await chain.proceed(chain.request);
      debugPrint('Request result: ${result.isSuccess ? "Success" : "Error"}');

      if (action == _FailedRequestResolverAction.retryOnce) break;

      final (act, error) = await result.when<FutureOr<_FailedRequestResolverResult>>(
        success: (_) {
          debugPrint('Request successful, releasing lock.');
          lock = null;
          return (_FailedRequestResolverAction.release, null);
        },
        error: (Exception error) {
          debugPrint('Request failed with error: $error');

          final runningLock = _findRunningLock(endpoint, error) ?? _findHandlerThenLock(endpoint, chain.request, error);

          if (runningLock == null) {
            debugPrint('No handler found, releasing.');
            lock = null;
            return (_FailedRequestResolverAction.release, null);
          }

          debugPrint('Lock found, waiting for resolution.');
          lock = runningLock;
          return runningLock.future;
        },
      );

      debugPrint('Resolver action determined: $act');
      action = act;
      errorReplacement = error;
    } while (action == _FailedRequestResolverAction.retry || action == _FailedRequestResolverAction.retryOnce);

    debugPrint('--- Finalizing interception with action: $action ---');
    return result.mapError((error) => errorReplacement ?? lock?.handler.transformError(error) ?? error);
  }

  final List<_FailedRequestResolverLock> _locks = <_FailedRequestResolverLock>[];

  _FailedRequestResolverLock? _findRunningLock(HttpEndpointBase<dynamic> endpoint, Exception error) {
    debugPrint('Checking for existing lock...');
    final lock = _locks.firstWhereOrNull((_FailedRequestResolverLock lock) => lock.isFor(endpoint, error));
    if (lock != null) {
      debugPrint('Existing lock found for endpoint: $endpoint');
    } else {
      debugPrint('No existing lock found for endpoint: $endpoint');
    }
    return lock;
  }

  _FailedRequestResolverLock? _findHandlerThenLock(
    HttpEndpointBase<dynamic> endpoint,
    BaseRequest request,
    Exception error,
  ) {
    debugPrint('Searching for handler for endpoint: $endpoint');
    final handler =
        _registry._handlers.firstWhereOrNull((FailedRequestHandler handler) => handler.canHandle(endpoint, error));
    if (handler == null) {
      debugPrint('No handler found for error: $error');
      return null;
    }

    debugPrint('Handler found, creating lock...');
    final resolver = _FailedRequestResolver(request, error);
    final lock = _createLock(handler, resolver);
    handler.onHandle(resolver);
    return lock;
  }

  _FailedRequestResolverLock _createLock(FailedRequestHandler handler, _FailedRequestResolver resolver) {
    debugPrint('Creating new resolver lock');
    final lock = _FailedRequestResolverLock(handler, resolver);
    _locks.add(lock);
    handler._currentResolver = resolver;
    resolver._completer.future.whenComplete(() {
      debugPrint('Resolver lock completed, removing lock');
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
    debugPrint('Retrying request');
    _completer.complete((_FailedRequestResolverAction.retry, null));
  }

  @override
  void retryOnce() {
    if (_completer.isCompleted) return;
    debugPrint('Retrying request once');
    _completer.complete((_FailedRequestResolverAction.retryOnce, null));
  }

  @override
  void release() {
    if (_completer.isCompleted) return;
    debugPrint('Releasing resolver');
    _completer.complete((_FailedRequestResolverAction.release, null));
  }

  @override
  void releaseAndReplaceError(Exception error) {
    if (_completer.isCompleted) return;
    debugPrint('Releasing resolver with error replacement');
    _completer.complete((_FailedRequestResolverAction.release, error));
  }
}
