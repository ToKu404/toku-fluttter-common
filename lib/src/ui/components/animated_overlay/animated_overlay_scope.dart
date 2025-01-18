part of animated_overlay;

class AnimatedOverlayScope extends StatefulWidget {
  const AnimatedOverlayScope({
    super.key,
    required this.child,
  });

  final Widget child;

  static _AnimatedOverlayScopeState of(BuildContext context) {
    final result = _checkContext(context) ??
        _findBelowContext(context) ??
        context.findAncestorStateOfType<_AnimatedOverlayScopeState>();
    assert(result != null, 'No AnimatedOverlayScope found in context');
    return result!;
  }

  static _AnimatedOverlayScopeState? _checkContext(BuildContext context) {
    if (context is StatefulElement && context.state is _AnimatedOverlayScopeState) {
      return context.state as _AnimatedOverlayScopeState;
    }
    return null;
  }

  static _AnimatedOverlayScopeState? _findBelowContext(BuildContext context) {
    assert(
      !context.debugDoingBuild,
      'Cannot obtain TutorialStage during build',
    );

    if (!(context is StatelessElement || context is StatefulElement)) {
      return null;
    }

    _AnimatedOverlayScopeState? state;
    context.visitChildElements((Element element) {
      if (!(element is StatefulElement && element.widget is _AnimatedOverlayScopeState)) {
        return;
      }
      state = element.state as _AnimatedOverlayScopeState;
    });

    if (state != null) return state!;
    return null;
  }

  @override
  _AnimatedOverlayScopeState createState() => _AnimatedOverlayScopeState();
}

class _AnimatedOverlayScopeState extends State<AnimatedOverlayScope> {
  @override
  Widget build(BuildContext context) {
    return Overlay(
      key: _overlayKey,
      initialEntries: [_childEntry],
    );
  }

  final GlobalKey<OverlayState> _overlayKey = GlobalKey<OverlayState>();
  OverlayState? get _overlay => _overlayKey.currentState;

  final List<_AnimatedOverlayEntry> _entries = <_AnimatedOverlayEntry>[];
  Iterable<OverlayEntry> get _overlayEntries {
    return [
      _childEntry,
      ..._entries.map((it) => it._overlayEntry),
    ];
  }

  void _insertEntry(_AnimatedOverlayEntry entry) {
    _entries
      ..add(entry)
      ..sort((a, b) => a.content.priority.index.compareTo(b.content.priority.index));
    _overlay?.rearrange(_overlayEntries);
  }

  late final OverlayEntry _childEntry = OverlayEntry(builder: _buildChild);
  final GlobalKey _childKey = GlobalKey();
  Widget _buildChild(BuildContext context) {
    return KeyedSubtree(
      key: _childKey,
      child: widget.child,
    );
  }

  bool _debugLocked = false;

  PopableContent insert(AnimatedOverlay content) {
    assert(!_debugLocked);
    assert(() {
      _debugLocked = true;
      return true;
    }());

    final _AnimatedOverlayEntry newEntry = _AnimatedOverlayEntry(content);
    newEntry._onRemove = () {
      _entries.remove(newEntry);
      newEntry._overlayEntry.remove();
    };
    _insertEntry(newEntry);

    assert(() {
      _debugLocked = false;
      return true;
    }());

    return content;
  }
}
