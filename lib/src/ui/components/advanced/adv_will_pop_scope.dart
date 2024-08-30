import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

enum AdvRoutePopDisposition {
  willPopNow,
  willPopLater,
  willNotPop,
  ;

  bool get isWillPopNow => this == AdvRoutePopDisposition.willPopNow;
  bool get isWillPopLater => this == AdvRoutePopDisposition.willPopLater;
  bool get isWillNotPop => this == AdvRoutePopDisposition.willNotPop;
}

class AdvWillPopScopeResult {
  Route<dynamic>? _route;
  Route<dynamic>? get route => _route;

  AdvRoutePopDisposition? _lastDisposition;
  AdvRoutePopDisposition? get lastDisposition => _lastDisposition;
}

typedef AdvWillPopCallback = Future<AdvRoutePopDisposition?> Function();

class AdvWillPopScope extends StatefulWidget {
  const AdvWillPopScope({
    super.key,
    required this.onWillPop,
    required this.child,
  });


  final AdvWillPopCallback onWillPop;

  final Widget child;

  @override
  _AdvWillPopScopeState createState() => _AdvWillPopScopeState();
}

class _AdvWillPopScopeState extends State<AdvWillPopScope> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }

  Future<bool> _onWillPop() async {
    final answer = await widget.onWillPop();
    if (!mounted) return true;
    context.read<AdvWillPopScopeResult>()
      .._route = ModalRoute.of(context)
      .._lastDisposition = answer;
    return answer == null;
  }
}
