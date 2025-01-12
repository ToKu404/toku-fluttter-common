
import 'package:flutter/widgets.dart';
import 'package:toku_flutter_common/core.dart';

typedef InfinityScrollChildBuilder = Widget Function(BuildContext context, ScrollController controller);

class InfinityScrollBuilder extends StatefulWidget {
  const InfinityScrollBuilder({
    super.key,
    this.onScrolledToBottom,
    required this.builder,
  });

  final VoidCallback? onScrolledToBottom;
  final InfinityScrollChildBuilder builder;

  @override
  State<InfinityScrollBuilder> createState() => _InfinityScrollBuilderState();
}

class _InfinityScrollBuilderState extends State<InfinityScrollBuilder>
    with AutoDisposeStateMixin<InfinityScrollBuilder> {
  @override
  Widget build(BuildContext context) => PrimaryScrollController(
        controller: _scrollController,
        child: widget.builder(context, _scrollController),
      );

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = autoDispose(ScrollController())..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients ||
        _scrollController.position.pixels < (_scrollController.position.maxScrollExtent - 80) ||
        _scrollController.position.axisDirection != AxisDirection.down) {
      return;
    }
    widget.onScrolledToBottom?.call();
  }
}
