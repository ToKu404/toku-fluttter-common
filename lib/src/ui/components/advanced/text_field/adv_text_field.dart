import 'package:toku_flutter_common/src/ui/components/advanced/text_field/adv_value_text_field.dart';

class AdvTextField extends AdvValueTextField<String> {
  const AdvTextField({
    super.key,
    super.value,
    super.onChanged,
    super.onSubmitted,
    super.onTap,
    super.clearOnTap,
    super.inputFormatters,
    super.inputType,
    super.inputAction,
    super.style,
    super.textAlign,
    super.textCapitalization,
    super.focusNode,
    super.showCursor,
    super.autocorrect,
    super.autofocus,
    super.readOnly,
    super.enabled,
    super.enableSuggestions,
    super.obscureText,
    super.withClearButton,
    super.withCounterText,
    super.hasValidationState,
    super.minLines,
    super.maxLines,
    super.maxLength,
    super.decoration,
    super.bordered,
    super.canError,
    super.withValidator,
    super.border,
  }) : super(valueConverter: const _StringTextConverter());
}

class _StringTextConverter extends AdvValueTextConverter<String> {
  const _StringTextConverter();

  @override
  String fromValue(String value) => value;

  @override
  String toValue(String text) => text;
}
