library animated_overlay;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

part 'animated_overlay_builder.dart';
part 'animated_overlay_entry.dart';
part 'animated_overlay_scope.dart';

Widget _defaultOverlayTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: secondaryAnimation,
    child: FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}

typedef OverlayTransitionsBuilder = Widget Function(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
);

typedef AnimatedOverlayBuilder = Widget Function(
  BuildContext context,
  PopableContent entry,
);

abstract interface class PopableContent {
  void pop();
}

enum AnimatedOverlayPriority {
  normal,
  high,
  ;
}

class AnimatedOverlay extends PopableContent with Diagnosticable {
  AnimatedOverlay({
    @visibleForTesting this.id,
    this.priority = AnimatedOverlayPriority.normal,
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.transitionsBuilder = _defaultOverlayTransitionsBuilder,
  });

  @visibleForTesting
  final Object? id;

  final AnimatedOverlayPriority priority;

  final Duration transitionDuration;

  final Duration reverseTransitionDuration;

  final AnimatedOverlayBuilder builder;

  final OverlayTransitionsBuilder transitionsBuilder;

  static PopableContent show({
    required BuildContext context,
    required AnimatedOverlay content,
  }) {
    return AnimatedOverlayScope.of(context).insert(content);
  }

  Widget buildContent(BuildContext context) => builder(context, this);

  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return transitionsBuilder(context, animation, secondaryAnimation, child);
  }

  /// A callback assigned by its entry to remove this toast from the stack
  VoidCallback? _onPopCallback;

  @override
  @nonVirtual
  void pop() {
    _onPopCallback?.call();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<Duration>(
        'transitionDuration',
        transitionDuration,
      ))
      ..add(DiagnosticsProperty<Duration>(
        'reverseTransitionDuration',
        reverseTransitionDuration,
      ))
      ..add(DiagnosticsProperty<VoidCallback?>(
        '_onPopCallback',
        _onPopCallback,
        missingIfNull: true,
      ));
  }
}

@visibleForTesting
enum OverlayLifecycle {
  entering,
  presenting,
  exiting,
}

@visibleForTesting
class OverlayLifecycleUpdateNotification extends Notification {
  @visibleForTesting
  const OverlayLifecycleUpdateNotification({
    required this.id,
    required this.state,
  });

  final Object? id;
  final OverlayLifecycle state;

  @override
  String toString() => 'OverlayLifecycleUpdateNotification(id: $id, state: $state)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OverlayLifecycleUpdateNotification && other.id == id && other.state == state;
  }

  @override
  int get hashCode => Object.hash(id, state, runtimeType);
}
