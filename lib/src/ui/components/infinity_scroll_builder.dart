import 'package:flutter/widgets.dart';

class InfinityScrollBuilder extends StatefulWidget {
  const InfinityScrollBuilder({
    super.key,
    required this.builder,
    required this.onScrolledToBottom,
    required this.hasNextPage,
  });

  final Widget Function(BuildContext context, ScrollController controller) builder;
  final Future<void> Function() onScrolledToBottom;
  final bool hasNextPage;

  @override
  State<InfinityScrollBuilder> createState() => _InfinityScrollBuilderState();
}

class _InfinityScrollBuilderState extends State<InfinityScrollBuilder> {
  late final ScrollController _controller;

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _controller = ScrollController()..addListener(_onScroll);
  }

  Future<void> _onScroll() async {
    if (!widget.hasNextPage) return;
    if (_loading) return;
    if (!_controller.hasClients) return;
    if (_controller.position.extentAfter > 80) return;

    setState(() => _loading = true);

    try {
      await widget.onScrolledToBottom.call();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
