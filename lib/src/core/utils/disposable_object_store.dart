import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:kartjis_mobile_common/src/core/utils/change_notifier_listener.dart';
import 'package:kartjis_mobile_common/src/core/utils/debouncer.dart';
import 'package:kartjis_mobile_common/src/core/utils/releasable_operation.dart';

class DisposableObjectStore {
  List<Object> _disposables = <Object>[];

  /// {@template core.base.DisposableObjectStore.autoDispose}
  /// Registers a [disposable] object that will be disposed when [disposeAll] is called.
  ///
  /// The [disposable] object must be one of the following types:
  /// - [ChangeNotifier]
  /// - [ChangeNotifierListener]
  /// - [StreamSink]
  /// - [StreamSubscription]
  /// - [AnimationEagerListenerMixin]
  /// - [Debouncer]
  /// - [ReleasableOperation]
  ///
  /// Otherwise an [AssertionError] will be thrown.
  /// {@endtemplate}
  @optionalTypeArgs
  @nonVirtual
  T add<T extends Object>(T disposable) {
    assert(
      !_disposables.contains(disposable),
      "You've already registered $disposable. Make sure to not register twice!",
    );
    assert(
      disposable is ChangeNotifier ||
          disposable is ChangeNotifierListener ||
          disposable is StreamSink ||
          disposable is StreamSubscription ||
          disposable is AnimationEagerListenerMixin ||
          disposable is Debouncer ||
          disposable is ReleasableOperation,
      'Unknown disposable object of ${disposable.runtimeType}',
    );
    _disposables.add(disposable);
    return disposable;
  }

  /// {@template core.base.DisposableObjectStore.dispose}
  /// Disposes all registered objects.
  /// {@endtemplate}
  void disposeAll() {
    final disposables = _disposables;
    _disposables = <Object>[];
    for (final disposable in disposables) {
      if (disposable is ChangeNotifier) {
        disposable.dispose();
      } else if (disposable is ChangeNotifierListener) {
        disposable.cancel();
      } else if (disposable is StreamSink) {
        disposable.close();
      } else if (disposable is StreamSubscription) {
        disposable.cancel();
      } else if (disposable is AnimationEagerListenerMixin) {
        disposable.dispose();
      } else if (disposable is Debouncer) {
        disposable.cancel();
      } else if (disposable is ReleasableOperation) {
        disposable.release();
      }
    }
  }
}
