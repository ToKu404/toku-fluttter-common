import 'dart:async';

import 'package:meta/meta.dart';

typedef _PredicateCallback<T> = bool Function(T previous, T current);

extension StreamExtensions<T> on Stream<T> {
  /// Skips data events if they do not satisfy [predicate].
  ///
  /// This is just the inverse of [Stream.distinct].
  Stream<T> when(_PredicateCallback<T> predicate) => distinct((T prev, T next) => !predicate(prev, next));

  Stream<T> whenLast2(_PredicateCallback<T> predicate) {
    return _MapWhenStream<T, T>(this, (_, T current) => current, predicate);
  }

  /// Maps the last 2 data events into a new data type if they satisfy [when].
  ///
  /// [when] defaults to checking if the previous and current data events are not equal.
  Stream<T2> mapLast2<T2>(
    T2 Function(T previous, T current) mapper, {
    _PredicateCallback<T>? when,
  }) {
    return _MapWhenStream(this, mapper, when);
  }

  Stream<T> count(int Function(int count, T data) onCount) => _CountStream<T>(this, onCount);
}

class _CountStream<S> extends ForwardingStream<S, S> {
  _CountStream(super.source, this._onCount);

  final int Function(int count, S data) _onCount;

  int _count = 0;

  @override
  void handleData(S data, EventSink<S> sink) {
    _count = _onCount(_count, data);
    sink.add(data);
  }
}


class _MapWhenStream<S, T> extends ForwardingStream<S, T> {
  _MapWhenStream(
    super.source,
    this._mapper, [
    _PredicateCallback<S>? predicate,
  ]) : _predicate = predicate ?? _defaultPredicate;

  final T Function(S previous, S current) _mapper;
  final _PredicateCallback<S> _predicate;

  static bool _defaultPredicate(dynamic previous, dynamic current) => previous != current;

  static final Object _sentinelValue = Object();
  dynamic _previous = _sentinelValue;

  @override
  void handleData(S data, EventSink<T> sink) {
    final dynamic previous = _previous;
    _previous = data;
    if (previous is S && _predicate(previous, data)) {
      sink.add(_mapper(previous, data));
    }
  }
}

/// Forwards [S] events to [T] events.
///
/// This is basically a lazy [Stream] that will only subscribe to the source stream
/// when at least one subscriber is listening to this stream.
///
/// This will also dispose itself when there are no more subscribers.
abstract class ForwardingStream<S, T> extends Stream<T> {
  /// Creates a [ForwardingStream] that forwards events from [source] to [T] events.
  ForwardingStream(Stream<S> source)
      : _source = source,
        isBroadcast = source.isBroadcast;

  final Stream<S> _source;

  @override
  final bool isBroadcast;

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    if (_isClosed) {
      throw StateError('Stream has already been closed');
    }

    if (_subscribersCount == 0) {
      _initController();
      _subscribeSource();
    }

    _subscribersCount++;
    return _controller!.stream.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  int _subscribersCount = 0;
  StreamController<T>? _controller;
  StreamSubscription<S>? _sourceSubscription;
  bool _isClosed = false;

  @visibleForTesting
  bool get isClosed => _isClosed;

  void _closeController() {
    if (_isClosed) return;
    _isClosed = true;
    _sourceSubscription?.cancel();
    _sourceSubscription = null;
    _controller?.close();
    _controller = null;
  }

  void _initController() {
    assert(_controller == null, 'StreamController has already been initialized');
    final StreamController<T> controller = isBroadcast ? StreamController<T>.broadcast() : StreamController<T>();
    controller.onCancel = _onCancel;
    if (!isBroadcast) {
      controller
        ..onPause = _onPause
        ..onResume = _onResume;
    }
    _controller = controller;
  }

  void _subscribeSource() {
    _sourceSubscription = _source.listen(
      _onData,
      onError: _onError,
      onDone: _closeController,
    );
  }

  void _onData(S data) {
    if (_isClosed) return;
    assert(_controller != null);
    handleData(data, _controller!.sink);
  }

  void handleData(S data, EventSink<T> sink);

  void _onError(Object error, StackTrace? stackTrace) {
    if (_isClosed) return;
    _controller?.addError(error, stackTrace);
  }

  void _onPause() {
    if (_isClosed) return;
    _sourceSubscription?.pause();
  }

  void _onResume() {
    if (_isClosed) return;
    _sourceSubscription?.resume();
  }

  void _onCancel() {
    if (_isClosed) return;
    if (--_subscribersCount == 0) _closeController();
  }
}
