import 'package:flutter/material.dart';

enum BrutalismGestureType {
  clicked,
  hovered,
}

class BrutalismCard extends StatefulWidget {
  const BrutalismCard({
    super.key,
    this.child,
    this.onTap,
    this.builder,
    this.isEnabled = true,
    required this.primaryColor,
    required this.layerColor,
    this.textColor,
    this.borderWidth,
    required this.layerSpace,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = 8,
    this.borderColor,
    this.height,
    this.width,
    this.gestureType = BrutalismGestureType.clicked,
  });
  final Widget? child;
  final Widget Function(bool isHover)? builder;
  final Color primaryColor;
  final Color layerColor;
  final Color? borderColor;
  final double? borderWidth;
  final double layerSpace;
  final Color? textColor;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final bool isEnabled;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final BrutalismGestureType gestureType;

  @override
  State<BrutalismCard> createState() => _BrutalismCardState();
}

class _BrutalismCardState extends State<BrutalismCard> {
  final ValueNotifier<bool> _onHoverNotifier = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    _onHoverNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _onHoverNotifier,
      builder: (context, onHover, _) {
        final child = Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: widget.width ?? double.infinity,
                height: widget.height,
                margin: EdgeInsets.only(
                  left: widget.layerSpace,
                  top: widget.layerSpace,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: widget.layerColor,
                  border: Border.all(
                    width: widget.borderWidth ?? 1,
                    color: widget.borderColor ?? Colors.black,
                  ),
                ),
                padding: widget.padding,
                child: const SizedBox(),
              ),
            ),
            AnimatedContainer(
              width: widget.width ?? double.infinity,
              height: widget.height,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              margin: onHover || !widget.isEnabled
                  ? EdgeInsets.only(
                      left: widget.layerSpace,
                      top: widget.layerSpace,
                    )
                  : EdgeInsets.only(
                      right: widget.layerSpace,
                      bottom: widget.layerSpace,
                    ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  color: widget.isEnabled ? widget.primaryColor : Colors.white,
                  border: Border.all(
                    width: widget.borderWidth ?? 1,
                    color: widget.isEnabled ? widget.borderColor ?? Colors.black : Colors.grey,
                  )),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(widget.borderRadius - (widget.layerSpace / 2)),
                child: Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: widget.child ?? widget.builder?.call(onHover),
                ),
              ),
            ),
          ],
        );
        if (widget.gestureType == BrutalismGestureType.clicked) {
          return GestureDetector(
            onTapDown: widget.isEnabled && widget.onTap != null
                ? (details) {
                    _onHoverNotifier.value = true;
                  }
                : null,
            onTapUp: widget.isEnabled && widget.onTap != null
                ? (details) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      _onHoverNotifier.value = false;
                      widget.onTap!.call();
                    });
                  }
                : null,
            onTapCancel: widget.isEnabled && widget.onTap != null
                ? () {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      _onHoverNotifier.value = false;
                      widget.onTap!.call();
                    });
                  }
                : null,
            child: child,
          );
        } else {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (event) {
              _onHoverNotifier.value = true;
            },
            onExit: (event) {
              _onHoverNotifier.value = false;
            },
            child: child,
          );
        }
      },
    );
  }
}
