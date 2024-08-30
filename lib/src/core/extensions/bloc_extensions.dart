import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/transformers.dart';

extension BlocExtensions<S> on StateStreamable<S> {
  Future<void> waitUntil(bool Function(S state) predicate) async {
    await for (final S state in stream) {
      if (predicate(state)) return;
    }
  }

  /// Returns a [Stream] that starts with the current [state].
  ///
  /// This is just a shorthand for `targetBloc.stream.startWith(targetBloc.state)`.
  Stream<S> get stateStream => stream.startWith(state);
}
