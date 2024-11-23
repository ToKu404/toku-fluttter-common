import 'package:flutter/material.dart';

class BrutalismCard extends StatefulWidget {
  const BrutalismCard(
      {super.key,
      required this.child,
      this.onTap,
      this.isEnabled = true,
      required this.primaryColor,
      required this.layerColor,
      this.textColor,
      this.borderWidth,
      required this.layerSpace,
      this.padding = const EdgeInsets.all(12),
      this.borderColor});
  final Widget child;
  final Color primaryColor;
  final Color layerColor;
  final Color? borderColor;
  final double? borderWidth;
  final double layerSpace;
  final Color? textColor;
  final VoidCallback? onTap;
  final bool isEnabled;
  final EdgeInsetsGeometry? padding;

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
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    margin: EdgeInsets.only(
                      left: widget.layerSpace,
                      top: widget.layerSpace,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
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
                  width: double.infinity,
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
                      borderRadius: BorderRadius.circular(8),
                      color:
                          widget.isEnabled ? widget.primaryColor : Colors.white,
                      border: Border.all(
                        width: widget.borderWidth ?? 1,
                        color: widget.isEnabled
                            ? widget.borderColor ?? Colors.black
                            : Colors.grey,
                      )),
                  child: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius:
                        BorderRadius.circular(8 - (widget.layerSpace / 2)),
                    child: Padding(
                      padding: widget.padding ?? EdgeInsets.zero,
                      child: widget.child,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
