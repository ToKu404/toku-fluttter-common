import 'package:flutter/widgets.dart';
import 'package:kartjis_mobile_common/core.dart';

mixin AutoDisposeStateMixin<S extends StatefulWidget> on State<S> {
  final DisposableObjectStore _store = DisposableObjectStore();

  @override
  void dispose() {
    _store.disposeAll();
    super.dispose();
  }

  /// {@macro core.base.DisposableObjectStore.autoDispose}
  @optionalTypeArgs
  @nonVirtual
  @protected
  T autoDispose<T extends Object>(T disposable) => _store.add(disposable);
}
