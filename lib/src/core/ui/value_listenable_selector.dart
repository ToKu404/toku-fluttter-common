import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef ValueWidgetSelector<V, T> = T Function(V value);

typedef ValueWidgetBuildWhen<T> = bool Function(T previous, T current);

/// A widget that rebuilds when the given [valueListenable] emits distinct value
/// defined by [selector].
///
/// [V] is the type of the value emitted by the [valueListenable].
///
/// [T] is the type of the value selected by [selector].
///
/// [buildWhen] is an optional function that can be used to control when the
/// [builder] function is called. Defaults to [T]'s equality operator.
class ValueListenableSelector<V, T> extends StatefulWidget {
  const ValueListenableSelector({
    super.key,
    required this.valueListenable,
    required this.selector,
    this.buildWhen,
    required this.builder,
    this.child,
  });

  final ValueListenable<V> valueListenable;
  final ValueWidgetSelector<V, T> selector;
  final ValueWidgetBuildWhen<T>? buildWhen;
  final ValueWidgetBuilder<T> builder;
  final Widget? child;

  @override
  State<ValueListenableSelector<V, T>> createState() =>
      _ValueListenableSelectorState<V, T>();
}

class _ValueListenableSelectorState<V, T>
    extends State<ValueListenableSelector<V, T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = _selectValue();
    widget.valueListenable.addListener(_valueChanged);
  }

  @override
  void didUpdateWidget(ValueListenableSelector<V, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueListenable != widget.valueListenable) {
      oldWidget.valueListenable.removeListener(_valueChanged);
      _value = _selectValue();
      widget.valueListenable.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.valueListenable.removeListener(_valueChanged);
    super.dispose();
  }

  T _selectValue() => widget.selector(widget.valueListenable.value);

  void _valueChanged() {
    final newValue = _selectValue();
    if (!_shouldRebuild(newValue)) return;
    setState(() => _value = newValue);
  }

  bool _shouldRebuild(T newValue) =>
      widget.buildWhen?.call(_value, newValue) ?? newValue != _value;

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, _value, widget.child);
}
