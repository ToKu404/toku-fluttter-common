import 'dart:async' show Completer, StreamController, StreamSubscription;

import 'package:kartjis_mobile_common/core.dart';

/// A class that can be used to run a single [Stream] operation and release it when needed
/// or when a new operation is run.
@injectable
class ReleasableOperation {
  StreamSubscription<dynamic>? _subscription;

  bool get isRunning => _subscription != null;

  /// The [onData] callback will be called for each value emitted by the [sourceFn].
  ///
  /// The [onReleased] callback will be called when the subscription to [sourceFn] is canceled.
  ///
  /// The [onCompleted] callback will be called when the [sourceFn] has done emitting values.
  ///
  /// **Note**: Running a new [sourceFn] will release the previous one if it's still running.
  @optionalTypeArgs
  Future<void> run<T>(
    Stream<T> Function() sourceFn,
    void Function(T data) onData, {
    void Function()? onReleased,
    void Function()? onCompleted,
  }) {
    release();
    final completer = Completer<void>();
    final controller = StreamController<T>();
    controller.onListen = () {
      final sourceSubscription =
          sourceFn().listen(controller.add, cancelOnError: true)
            ..onError(completer.completeError)
            ..onDone(() {
              completer.maybeComplete();
              onCompleted?.call();
            });
      controller.onCancel = () {
        sourceSubscription.cancel();
        completer.maybeComplete();
        onReleased?.call();
      };
    };
    _subscription = controller.stream.listen(onData);
    return completer.future.whenComplete(() {
      controller
        ..onCancel = null
        ..close();
      _subscription = null;
    });
  }

  /// Release the current operation if it's still running.
  void release() {
    _subscription?.cancel();
    // no need to set [_subscription] to null because
    // [completer.future.whenComplete] will do it
  }
}
