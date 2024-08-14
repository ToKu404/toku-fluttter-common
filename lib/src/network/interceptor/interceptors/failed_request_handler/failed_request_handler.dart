part of failed_request_handler_interceptor;

abstract class FailedRequestResolver {
  BaseRequest get request;

  Exception get error;

  void retry();

  /// Retries the request only once then releases it regardless of the result.
  void retryOnce();

  void release();

  /// This releases the lock and replaces error with [error]
  void releaseAndReplaceError(Exception error);
}

abstract class FailedRequestHandler {
  /// Whether this handler would like to handle the [endpoint] with [error].
  bool canHandle(HttpEndpointBase<dynamic> endpoint, Exception error);

  /// Called when [InterceptorChain] returns [Exception]
  ///
  /// At least [FailedRequestResolver.retry] or [FailedRequestResolver.release]
  /// must be called after handling the error.
  ///
  /// Otherwise, the request will be stuck.
  void onHandle(FailedRequestResolver resolver);

  /// Transforms the [error] to another error.
  ///
  /// This will be ignored when [FailedRequestResolver.releaseAndReplaceError] is called.
  Exception transformError(Exception error) => error;

  FailedRequestResolver? _currentResolver;

  /// Releases any resources including the current [FailedRequestResolver] if any.
  ///
  /// This is called when the handler is removed from the registry.
  @mustCallSuper
  void release() {
    _currentResolver?.release();
    _currentResolver = null;
  }
}
