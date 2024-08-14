part of failed_request_handler_interceptor;

abstract class FailedRequestHandlerRegistry {
  factory FailedRequestHandlerRegistry() = _FailedRequestHandlerRegistryImpl;

  /// Read-only list of [FailedRequestHandler]s.
  List<FailedRequestHandler> get _handlers;

  /// Add [handler] to the end of the chain.
  void addHandler(FailedRequestHandler handler);

  /// Add [handlers] to the end of the chain.
  void addHandlers(Iterable<FailedRequestHandler> handlers);

  /// Remove [handler] from the chain.
  ///
  /// This also calls [FailedRequestHandler.release] on [handler].
  void removeHandler(FailedRequestHandler handler);
}

class _FailedRequestHandlerRegistryImpl implements FailedRequestHandlerRegistry {
  @override
  List<FailedRequestHandler> _handlers = <FailedRequestHandler>[];

  @override
  void addHandler(FailedRequestHandler handler) {
    assert(
      !_handlers.contains(handler),
      'Handler $handler is already registered.',
    );
    _handlers = List<FailedRequestHandler>.unmodifiable(<FailedRequestHandler>[
      ..._handlers,
      handler,
    ]);
  }

  @override
  void addHandlers(Iterable<FailedRequestHandler> handlers) {
    assert(() {
      final thisHandlersSet = _handlers.toSet();
      final handlersSet = handlers.toSet();
      final duplicateHandlers = thisHandlersSet.intersection(handlersSet);
      if (duplicateHandlers.isNotEmpty) {
        throw StateError('One or more handlers are already registered: $duplicateHandlers');
      }
      return true;
    }());
    _handlers = List<FailedRequestHandler>.unmodifiable(<FailedRequestHandler>[
      ..._handlers,
      ...handlers,
    ]);
  }

  @override
  void removeHandler(FailedRequestHandler handler) {
    handler.release();
    bool foundHandler = false;
    _handlers = List<FailedRequestHandler>.unmodifiable(
      _handlers.where((FailedRequestHandler e) {
        assert(() {
          foundHandler |= e == handler;
          return true;
        }());
        return e != handler;
      }),
    );
    assert(foundHandler, 'Handler $handler not found in registry.');
  }
}
