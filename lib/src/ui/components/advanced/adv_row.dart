
import 'package:flutter/material.dart';

class AdvRow extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline? textBaseline;
  final List<Widget?> children;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? divider;

  const AdvRow({
    Key? key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection = TextDirection.ltr,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
    this.children = const <Widget>[],
    this.padding,
    this.margin,
    this.divider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newChildren = <Widget>[];

    for (final child in children) {
      if (child != null) {
        newChildren.add(child);
        if (divider != null) newChildren.add(divider!);
      }
    }

    if (newChildren.isNotEmpty && divider != null) {
      newChildren.removeAt(newChildren.length - 1);
    }

    return Container(
        padding: padding,
        margin: margin,
        child: Row(
          key: key,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
          children: newChildren,
        ));
  }
}

class RowDivider extends StatelessWidget {
  final double size;
  final Color color;

  const RowDivider(double? size, {Key? key, this.color = Colors.transparent})
      : size = size ?? 0.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(width: size, height: 1.0, color: color);
  }
}
