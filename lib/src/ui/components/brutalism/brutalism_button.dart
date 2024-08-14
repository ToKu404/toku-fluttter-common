import 'package:flutter/material.dart';

class BrutalismButton extends StatefulWidget {
  final String title;
  final Color primaryColor;
  final Color layerColor;
  final Color? borderColor;
  final double layerSpace;
  final Color? textColor;
  final VoidCallback onTap;
  final bool isEnabled;
  final Widget? leading;
  const BrutalismButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.leading,
      this.isEnabled = true,
      required this.primaryColor,
      required this.layerColor,
      this.textColor,
      required this.layerSpace,
      this.borderColor});

  @override
  State<BrutalismButton> createState() => _BrutalismButtonState();
}

class _BrutalismButtonState extends State<BrutalismButton> {
  final ValueNotifier<bool> _onHoverNotifier = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    _onHoverNotifier.dispose();
  }

  void _onTap() {
    FocusScope.of(context).unfocus();
    Future.delayed(const Duration(milliseconds: 200), () {
      _onHoverNotifier.value = false;
      widget.onTap.call();
    });
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
            onTapUp: widget.isEnabled ? (details) => _onTap() : null,
            onTapCancel: widget.isEnabled ? () => _onTap() : null,
            child: Stack(
              children: [
                Container(
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
                    child: const SizedBox()),
                AnimatedContainer(
                  width: double.infinity,
                  height: 45,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.leading != null) ...[
                        widget.leading!,
                        const SizedBox(
                          width: 4,
                        )
                      ],
                      Center(
                        child: Text(
                          widget.title,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: widget.isEnabled ? widget.textColor ?? Colors.white : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
