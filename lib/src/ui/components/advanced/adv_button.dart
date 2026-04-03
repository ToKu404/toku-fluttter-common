import 'package:flutter/material.dart';

enum ButtonSize { small, large }

const _kDoubleTapPreventionDuration = Duration(milliseconds: 300);

enum ButtonWidthSize {
  none,
  standard,
  medium,
  large,
}

const Map<ButtonWidthSize, double?> _kButtonWidths = {
  ButtonWidthSize.none: null,
  ButtonWidthSize.standard: 110,
  ButtonWidthSize.medium: 160,
  ButtonWidthSize.large: 230,
};

const kDefaultAdvButtonHeight = 40.0;

class AdvButton extends StatefulWidget {
  const AdvButton._({
    this.text,
    this.child,
    this.circular = 8.0,
    bool bold = false,
    this.enable = true,
    this.onlyBorder = false,
    this.reverse = false,
    this.onPressed,
    this.buttonSize = ButtonSize.small,
    this.primaryColor,
    this.splashColor,
    this.highlightColor,
    this.accentColor,
    this.width,
    this.height = kDefaultAdvButtonHeight,
    this.borderWidth,
    this.padding,
    this.margin,
    this.buttonWidthSize = ButtonWidthSize.standard,
    bool? dismissKeyboardOnPressed,
  }) : _bold = bold,
       dismissKeyboardOnPressed = dismissKeyboardOnPressed ?? true;
  factory AdvButton.text(
    String text, {
    double circular = 8.0,
    bool enable = true,
    bool onlyBorder = false,
    bool reverse = false,
    bool bold = false,
    VoidCallback? onPressed,
    ButtonSize buttonSize = ButtonSize.small,
    Color? backgroundColor,
    Color? textColor,
    Color? splashColor,
    Color? highlightColor,
    double? width,
    double? height = 40,
    double? borderWidth,
    EdgeInsets? padding,
    EdgeInsets? margin,
    ButtonWidthSize buttonWidthSize = ButtonWidthSize.standard,
    bool? dismissKeyboardOnPressed,
  }) {
    final primaryColor = backgroundColor;
    final accentColor = textColor;

    return AdvButton._(
      text: text,
      circular: circular,
      enable: enable,
      bold: bold,
      onlyBorder: onlyBorder,
      reverse: reverse,
      onPressed: onPressed,
      buttonSize: buttonSize,
      primaryColor: primaryColor,
      accentColor: accentColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      width: width,
      height: height,
      borderWidth: borderWidth,
      padding: padding,
      margin: margin,
      buttonWidthSize: buttonWidthSize,
      dismissKeyboardOnPressed: dismissKeyboardOnPressed ?? true,
    );
  }

  factory AdvButton.custom({
    required Widget child,
    double circular = 5.0,
    bool enable = true,
    bool onlyBorder = false,
    bool reverse = false,
    VoidCallback? onPressed,
    ButtonSize buttonSize = ButtonSize.small,
    Color? primaryColor,
    Color? accentColor,
    Color? splashColor,
    Color? highlightColor,
    double? width,
    double? height = 40,
    double? borderWidth,
    EdgeInsets? padding,
    EdgeInsets? margin,
    ButtonWidthSize buttonWidthSize = ButtonWidthSize.standard,
    bool? dismissKeyboardOnPressed,
  }) {
    return AdvButton._(
      circular: circular,
      enable: enable,
      onlyBorder: onlyBorder,
      reverse: reverse,
      onPressed: onPressed,
      buttonSize: buttonSize,
      primaryColor: primaryColor,
      accentColor: accentColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      width: width,
      height: height,
      borderWidth: borderWidth,
      padding: padding,
      margin: margin,
      buttonWidthSize: buttonWidthSize,
      dismissKeyboardOnPressed: dismissKeyboardOnPressed ?? true,
      child: child,
    );
  }
  final String? text;
  final Widget? child;
  final bool _bold;
  final bool enable;
  final VoidCallback? onPressed;
  final double circular;
  final ButtonSize buttonSize;
  final bool onlyBorder;
  final bool reverse;
  final Color? primaryColor;
  final Color? accentColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? width;
  final double? height;
  final double? borderWidth;
  final ButtonWidthSize buttonWidthSize;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool dismissKeyboardOnPressed;

  @override
  _AdvButtonState createState() => _AdvButtonState();
}

class _AdvButtonState extends State<AdvButton> {
  bool _working = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = !widget.reverse ? widget.primaryColor ?? Colors.orange : widget.accentColor ?? Colors.white;

    final accentColor = !widget.reverse ? widget.accentColor ?? Colors.white : widget.primaryColor ?? Colors.blueGrey;

    final borderWidth = widget.onlyBorder ? (widget.borderWidth ?? 1.0) : 0.0;
    final disableBackgroundColor = Color.lerp(
      widget.reverse ? Colors.white : Colors.black54,
      const Color(0xffd9d9df),
      0.6,
    )!;
    final disableTextColor = Color.lerp(!widget.reverse ? Colors.white : Colors.black54, const Color(0xffd9d9df), 0.6)!;

    final ShapeBorder border = RoundedRectangleBorder(
      side: BorderSide(color: widget.enable ? primaryColor : disableBackgroundColor, width: borderWidth),
      borderRadius: BorderRadius.circular(widget.circular),
    );

    final color = widget.onlyBorder ? accentColor : primaryColor;
    final disableColor = widget.onlyBorder ? disableTextColor : disableBackgroundColor;
    final disableTextColor0 = !widget.onlyBorder ? disableTextColor : disableBackgroundColor;

    final finalPadding =
        widget.padding ??
        (widget.buttonSize == ButtonSize.large ? const EdgeInsets.all(14.0) : const EdgeInsets.all(8.0));

    var child = widget.child;

    if (widget.child == null) {
      final fontSize = widget.buttonSize == ButtonSize.large ? 18.0 : 14.0;
      final fontWeight = widget._bold ? FontWeight.w700 : FontWeight.w500;
      final disableTextColor = Color.lerp(
        !widget.reverse ? Colors.white : Colors.black54,
        const Color(0xffd9d9df),
        0.6,
      )!;
      final disableBackgroundColor = Color.lerp(
        widget.reverse ? Colors.white : Colors.black54,
        const Color(0xffd9d9df),
        0.6,
      )!;
      final textColor = !widget.onlyBorder ? accentColor : primaryColor;
      final disableTextColor1 = !widget.onlyBorder ? disableTextColor : disableBackgroundColor;
      final textStyle = TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: widget.enable ? textColor : disableTextColor1,
      );

      child = Text(widget.text!, style: textStyle);
    }

    return ButtonTheme(
      minWidth: 0.0,
      height: 0.0,
      child: Container(
        margin: widget.margin,
        width: widget.width ?? _kButtonWidths[widget.buttonWidthSize],
        height: widget.height,
        child: MaterialButton(
          padding: finalPadding.copyWith(top: 5, bottom: 5),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          color: color,
          elevation: widget.primaryColor == Colors.transparent ? 0 : 0.1,
          focusElevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          disabledColor: disableColor,
          disabledTextColor: disableTextColor0,
          highlightColor: widget.highlightColor ?? Colors.white.withValues(alpha: .1),
          splashColor: widget.splashColor ?? Colors.white.withValues(alpha: .2),
          onPressed: widget.enable
              ? () {
                  if (_working) {
                    return;
                  }

                  _working = true;
                  Future.delayed(
                    _kDoubleTapPreventionDuration,
                  ).then((value) => _working = false);

                  if (widget.dismissKeyboardOnPressed) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }

                  if (widget.onPressed != null) widget.onPressed?.call();
                }
              : null,
          shape: border,
          child: child,
        ),
      ),
    );
  }
}
