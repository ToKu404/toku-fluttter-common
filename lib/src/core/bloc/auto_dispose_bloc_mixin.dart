import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartjis_mobile_common/core.dart';
import 'package:kartjis_mobile_common/src/core/utils/disposable_object_store.dart';

mixin AutoDisposeBlocMixin<BlocState> on BlocBase<BlocState> {
  final DisposableObjectStore _store = DisposableObjectStore();

  @override
  Future<void> close() {
    _store.disposeAll();
    return super.close();
  }

  /// {@macro core.base.DisposableObjectStore.dispose}
  void disposeAll() => _store.disposeAll();

  /// {@macro core.base.DisposableObjectStore.autoDispose}
  @optionalTypeArgs
  @nonVirtual
  @protected
  T autoDispose<T extends Object>(T disposable) => _store.add(disposable);
}
