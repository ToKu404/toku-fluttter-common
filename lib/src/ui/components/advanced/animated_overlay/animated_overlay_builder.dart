part of animated_overlay;

enum _AnimatedOverlayLifecycle {
  initialized,
  entering,
  presenting,
  exiting,
  exited,
  disposed,
}

class _AnimatedOverlayBuilder extends StatefulWidget {
  const _AnimatedOverlayBuilder({
    Key? key,
    required this.entry,
  }) : super(key: key);

  final _AnimatedOverlayEntry entry;

  @override
  State<_AnimatedOverlayBuilder> createState() => _AnimatedOverlayBuilderState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<_AnimatedOverlayEntry>('entry', entry));
  }
}

class _AnimatedOverlayBuilderState extends State<_AnimatedOverlayBuilder>
    with SingleTickerProviderStateMixin<_AnimatedOverlayBuilder> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return _content.buildTransitions(
          context,
          _animation,
          _secondaryAnimation,
          IgnorePointer(
            ignoring: _shouldIgnoreUserGesture,
            child: child,
          ),
        );
      },
      child: Builder(
        builder: (BuildContext context) {
          return _content.buildContent(context);
        },
      ),
    );
  }

  late final AnimationController _animationController;
  late final ProxyAnimation _animation;
  late final ProxyAnimation _secondaryAnimation;

  _AnimatedOverlayLifecycle _currentState = _AnimatedOverlayLifecycle.initialized;
  OverlayLifecycle _currentOverlayLifecycle = OverlayLifecycle.entering;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _content.transitionDuration,
      reverseDuration: _content.reverseTransitionDuration,
    );
    _animation = ProxyAnimation(_animationController.view);
    _secondaryAnimation = ProxyAnimation(kAlwaysCompleteAnimation);
    _beginEnterTransition();
  }

  AnimatedOverlay get _content => widget.entry.content;

  bool get _shouldIgnoreUserGesture {
    return !(_currentState == _AnimatedOverlayLifecycle.presenting ||
        _currentState == _AnimatedOverlayLifecycle.exiting);
  }

  bool get _isUnavailable {
    return _currentState == _AnimatedOverlayLifecycle.exiting || _isInactive;
  }

  bool get _isInactive {
    return _currentState == _AnimatedOverlayLifecycle.exited || _currentState == _AnimatedOverlayLifecycle.disposed;
  }

  /// This is only used for testing
  void _dispatchLifecycleUpdate() {
    OverlayLifecycleUpdateNotification(
      id: _content.id,
      state: _currentOverlayLifecycle,
    ).dispatch(context);
  }

  Future<void> _beginEnterTransition() async {
    if (_isUnavailable) return;
    _currentState = _AnimatedOverlayLifecycle.entering;
    if (kDebugMode) _dispatchLifecycleUpdate();
    await _animationController.forward();
    _beginPresenting();
  }

  void _beginPresenting() {
    if (_isUnavailable) return;
    _currentState = _AnimatedOverlayLifecycle.presenting;
    if (kDebugMode) {
      _currentOverlayLifecycle = OverlayLifecycle.presenting;
      _dispatchLifecycleUpdate();
    }
  }

  Future<void> _beginExitTransition() async {
    if (_isUnavailable) return;
    _currentState = _AnimatedOverlayLifecycle.exiting;
    if (kDebugMode && _currentOverlayLifecycle != OverlayLifecycle.exiting) {
      _currentOverlayLifecycle = OverlayLifecycle.exiting;
      _dispatchLifecycleUpdate();
    }
    final Animation<double>? current = _animation.parent;
    _animation.parent = kAlwaysCompleteAnimation;
    _secondaryAnimation.parent = current;
    await _animationController.reverse();
    _beginExit();
  }

  void _beginExit() {
    if (_isInactive) return;
    _currentState = _AnimatedOverlayLifecycle.exited;
    if (kDebugMode && _currentOverlayLifecycle != OverlayLifecycle.exiting) {
      _currentOverlayLifecycle = OverlayLifecycle.exiting;
      _dispatchLifecycleUpdate();
    }
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    widget.entry.beginRemove();
  }

  void _beginDispose() {
    _currentState = _AnimatedOverlayLifecycle.disposed;
    _animationController.dispose();
  }

  @override
  void dispose() {
    _beginDispose();
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<_AnimatedOverlayLifecycle>(
      '_currentState',
      _currentState,
    ));
  }
}
