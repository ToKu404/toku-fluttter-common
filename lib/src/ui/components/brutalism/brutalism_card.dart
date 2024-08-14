import 'package:flutter/material.dart';

class BrutalismCard extends StatefulWidget {
  final Widget child;
  final Color primaryColor;
  final Color layerColor;
  final Color? borderColor;
  final double layerSpace;
  final Color? textColor;
  final VoidCallback onTap;
  final bool isEnabled;
  const BrutalismCard(
      {super.key,
      required this.child,
      required this.onTap,
      this.isEnabled = true,
      required this.primaryColor,
      required this.layerColor,
      this.textColor,
      required this.layerSpace,
      this.borderColor});

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
            onTapDown: widget.isEnabled
                ? (details) {
                    _onHoverNotifier.value = true;
                  }
                : null,
            onTapUp: widget.isEnabled
                ? (details) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      _onHoverNotifier.value = false;
                      widget.onTap.call();
                    });
                  }
                : null,
            onTapCancel: widget.isEnabled
                ? () {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      _onHoverNotifier.value = false;
                      widget.onTap.call();
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
                        width: 1,
                        color: widget.borderColor ?? Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
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
                      color: widget.isEnabled ? widget.primaryColor : Colors.white,
                      border: Border.all(
                        width: 1,
                        color: widget.isEnabled ? widget.borderColor ?? Colors.black : Colors.grey,
                      )),
                  padding: const EdgeInsets.all(12),
                  child: widget.child,
                ),
              ],
            ),
          );
        });
  }
}
