import 'package:flutter/material.dart';

class InkWellContainer extends StatelessWidget {
  final BorderRadius? borderRadius;
  final Color? color;
  final BoxBorder? border;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final Widget? child;

  const InkWellContainer({
    super.key,
    this.borderRadius,
    this.color,
    this.border,
    this.margin,
    this.padding,
    this.boxShadow,
    this.onTap,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color,
        border: border,
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius,
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
