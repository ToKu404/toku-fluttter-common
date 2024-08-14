import 'package:flutter/foundation.dart';

abstract class ChangeNotifierListener {
  @optionalTypeArgs
  static ChangeNotifierListener listen<T extends ChangeNotifier>({
    required T target,
    required ChangeNotifierChanged<T> listener,
  }) {
    return _ChangeNotifierListenerImpl<T>(target, listener);
  }

  @optionalTypeArgs
  static ChangeNotifierListener select<T extends ChangeNotifier, V>({
    required T target,
    required ChangeNotifierSelector<T, V> selector,
    required ValueChanged<V> listener,
  }) {
    return _ChangeNotifierSelectorImpl<T, V>(target, selector, listener);
  }

  /// Stops listening to the target [ChangeNotifier].
  ///
  /// This is the same as calling [ChangeNotifier.removeListener] on the target.
  void cancel();
}

typedef ChangeNotifierChanged<T extends ChangeNotifier> = void Function(T notifier);

class _ChangeNotifierListenerImpl<T extends ChangeNotifier> implements ChangeNotifierListener {
  _ChangeNotifierListenerImpl(this._target, this._listener) {
    _target.addListener(_listen);
  }

  final T _target;
  final ChangeNotifierChanged<T> _listener;

  void _listen() {
    _listener(_target);
  }

  @override
  void cancel() {
    _target.removeListener(_listen);
  }
}

typedef ChangeNotifierSelector<T extends ChangeNotifier, V> = V Function(T notifier);

class _ChangeNotifierSelectorImpl<T extends ChangeNotifier, V> implements ChangeNotifierListener {
  _ChangeNotifierSelectorImpl(this._target, this._selector, this._listener) {
    _lastValue = _selector(_target);
    _target.addListener(_listen);
  }

  final T _target;
  final ChangeNotifierSelector<T, V> _selector;
  final ValueChanged<V> _listener;

  late V _lastValue;

  void _listen() {
    final newValue = _selector(_target);
    if (newValue == _lastValue) return;
    _listener(newValue);
    _lastValue = newValue;
  }

  @override
  void cancel() {
    _target.removeListener(_listen);
  }
}
