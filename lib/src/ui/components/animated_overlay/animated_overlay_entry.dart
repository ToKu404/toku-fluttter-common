part of animated_overlay;

class _AnimatedOverlayEntry with Diagnosticable {
  _AnimatedOverlayEntry(this.content) {
    content._onPopCallback = _onContentPop;
    _createOverlayEntry();
  }

  final AnimatedOverlay content;

  /// A callback assigned in [AnimatedOverlay.show] to remove this entry
  /// from the stack and from the overlay stack
  VoidCallback? _onRemove;

  final GlobalKey<_AnimatedOverlayBuilderState> _builderKey = GlobalKey<_AnimatedOverlayBuilderState>();

  late final OverlayEntry _overlayEntry;
  void _createOverlayEntry() {
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (_) => _AnimatedOverlayBuilder(key: _builderKey, entry: this),
    );
    _overlayEntry = overlayEntry;
  }

  void beginRemove() {
    _onRemove?.call();
    _onRemove = null;
  }

  void _onContentPop() {
    if (_builderKey.currentState == null) return;
    _builderKey.currentState?._beginExitTransition();
    content._onPopCallback = null;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<AnimatedOverlay>('content', content))
      ..add(DiagnosticsProperty<VoidCallback?>(
        '_onRemove',
        _onRemove,
        missingIfNull: true,
      ));
  }
}
