import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:toku_flutter_common/src/core/ui/keyed_value.dart';

class PointerSaver extends StatefulWidget {
  const PointerSaver({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PointerSaver> createState() => _PointerSaverState();
}

class _PointerSaverState extends State<PointerSaver> {
  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      intercepting: context.select<PointerSaverNotifier, bool>((it) => it.value.value),
      child: KeyedSubtree(
        key: _childKey,
        child: widget.child,
      ),
    );
  }

  final GlobalKey _childKey = GlobalKey();
}

class PointerSaverNotifier extends ChangeNotifier implements ValueListenable<KeyedBool> {
  /// Creates a [ChangeNotifier] that wraps [KeyedBool].
  PointerSaverNotifier() {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  @override
  KeyedBool get value => _value;
  KeyedBool _value = const KeyedBool(key: Object(), value: false);
  set value(KeyedBool newValue) {
    // This won't notify listeners if:
    // - The new value is the same as the current one.
    // - The new value is disabled and has a different key from the current one. This is to prevent
    //   the pointer saver from being disabled by a widget when another widget already enabled it.
    if (_value == newValue || (!newValue.value && newValue.key != _value.key)) {
      return;
    }
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}

class PointerInterceptingWidget extends StatefulWidget {
  const PointerInterceptingWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<PointerInterceptingWidget> createState() => _PointerInterceptingWidgetState();
}

class _PointerInterceptingWidgetState extends State<PointerInterceptingWidget> {
  @override
  Widget build(BuildContext context) => widget.child;

  final Object _pointerSaverNotifierKey = Object();
  PointerSaverNotifier? _pointerSaverNotifier;

  @override
  void initState() {
    super.initState();
    _updatePointerSaverNotifier();
    _setHtmlElementShowing(true);
  }

  @override
  void activate() {
    super.activate();
    _updatePointerSaverNotifier();
  }

  @override
  void dispose() {
    _setHtmlElementShowing(false);
    super.dispose();
  }

  void _updatePointerSaverNotifier() {
    _pointerSaverNotifier = context.read<PointerSaverNotifier>();
  }

  void _setHtmlElementShowing(bool isEnabled) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _pointerSaverNotifier?.value = KeyedBool(
        key: _pointerSaverNotifierKey,
        value: isEnabled,
      );
    });
  }
}
