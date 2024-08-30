// ignore_for_file: omit_local_variable_types

part of adv_text_field;

abstract class AdvValueTextConverter<T extends Object?> {
  const AdvValueTextConverter();

  String fromValue(T value);

  T toValue(String text);
}
