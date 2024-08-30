part of adv_text_field;

class AdvValueTextFieldValidationText {
  const AdvValueTextFieldValidationText({
    required this.status,
    required this.text,
  });

  /// Returns an [AdvValueTextFieldValidationText] with [FieldValidationStatus.error]
  /// when [errorText] is not null, otherwise returns null.
  static AdvValueTextFieldValidationText? fromString(String? errorText) {
    if (errorText == null) return null;
    return AdvValueTextFieldValidationText(
      status: FieldValidationStatus.error,
      text: errorText,
    );
  }

  final FieldValidationStatus status;
  final String? text;

  static const AdvValueTextFieldValidationText pending = AdvValueTextFieldValidationText(
    status: FieldValidationStatus.pending,
    text: null,
  );
}
