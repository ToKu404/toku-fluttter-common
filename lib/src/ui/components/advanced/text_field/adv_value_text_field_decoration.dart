part of adv_text_field;

class AdvValueTextFieldDecoration {
  const AdvValueTextFieldDecoration({
    this.prefix,
    this.prefixWidth,
    this.isPrefixInsideBox = true,
    this.suffix,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.isRequired = false,
    this.validationText,
  });

  /// Optional widget to place on the line before the input.
  ///
  /// This can be used to add a custom widget in front of the input.
  /// The widget's baseline is lined up with the input
  /// baseline.
  ///
  /// See also:
  ///
  ///  * [suffix], the equivalent but on the trailing edge.
  final Widget? prefix;

  /// The width of the [prefix] widget.
  ///
  /// This would only be used if [isPrefixInsideBox] is set to false and [prefix] is not `null`.
  final double? prefixWidth;

  /// Whether the [prefix] widget is inside the text field or not.
  final bool isPrefixInsideBox;

  /// Optional widget to place on the line after the input.
  ///
  /// This can be used to add a custom widget after the input.
  /// The widget's baseline is lined up with the input baseline.
  ///
  /// The [suffix] appears after the [errorText] tooltip icon,
  /// if both are specified.
  ///
  /// See also:
  ///
  ///  * [prefix], the equivalent but on the leading edge.
  final Widget? suffix;

  final String? labelText;
  final String? hintText;
  final IconData? prefixIcon;

  final bool isRequired;

  /// The validation text to display at the end of the input field.
  /// If null, no validation text is displayed.
  final AdvValueTextFieldValidationText? validationText;
}
