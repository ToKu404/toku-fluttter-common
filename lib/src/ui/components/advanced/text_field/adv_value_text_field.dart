library adv_text_field;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toku_flutter_common/core.dart';
import 'package:toku_flutter_common/src/ui/components/advanced/text_field/field_validation_status.dart';

part 'adv_value_text_converter.dart';
part 'adv_value_text_field_decoration.dart';
part 'adv_value_text_field_validation_text.dart';

class AdvValueTextField<T extends Object?> extends StatefulWidget {
  const AdvValueTextField({
    super.key,
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.clearOnTap = false,
    this.inputFormatters,
    required this.valueConverter,
    this.inputType,
    this.inputAction,
    this.style,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.showCursor,
    this.autocorrect = true,
    this.autofocus = false,
    this.readOnly = false,
    this.enabled = true,
    this.enableSuggestions = true,
    this.obscureText = false,
    this.withClearButton = false,
    this.withCounterText = false,
    this.hasValidationState = true,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.decoration,
    this.bordered = true,
    this.canError = true,
    this.withValidator = true,
    this.border,
  });

  final T? value;
  final ValueChanged<T>? onChanged;
  final ValueChanged<T>? onSubmitted;
  final VoidCallback? onTap;

  /// Whether to clear the text field when the user taps on it.
  final bool clearOnTap;
  final List<TextInputFormatter>? inputFormatters;
  final AdvValueTextConverter<T> valueConverter;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final bool? showCursor;
  final bool autocorrect;
  final bool autofocus;
  final bool readOnly;
  final bool enabled;
  final bool enableSuggestions;
  final bool obscureText;
  final bool withClearButton;
  final bool withCounterText;
  final bool bordered;
  final bool canError;
  final bool withValidator;
  final InputBorder? border;

  /// Whether to show the validation state of the text field.
  ///
  /// If this is `false`, then [AdvValueTextFieldDecoration.validationText] will be ignored and
  /// there won't be any extra space at the bottom of the text field.
  ///
  /// Defaults to `true`
  final bool hasValidationState;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final AdvValueTextFieldDecoration? decoration;

  @override
  _AdvValueTextFieldState<T> createState() => _AdvValueTextFieldState<T>();
}

class _AdvValueTextFieldState<T extends Object?>
    extends State<AdvValueTextField<T>>
    with AutoDisposeStateMixin<AdvValueTextField<T>> {
  @override
  Widget build(BuildContext context) {
    final hasValidationState = widget.hasValidationState;
    final decoration = widget.decoration;
    final validationText = decoration?.validationText;
    final suffix = decoration?.suffix;
    final effectiveStyle =
        widget.style?.copyWith(height: 1.25) ?? const TextStyle(height: 1.25);
    final effectiveHintStyle = widget.style?.copyWith(color: Colors.grey);
    TextStyle effectiveErrorStyle =
        widget.style?.copyWith(height: 0.3) ?? const TextStyle(height: 0.4);
    final String? effectiveErrorText;
    final InputBorder? errorBorder;
    if (hasValidationState) {
      effectiveErrorText = validationText?.text ??
          (validationText?.status == FieldValidationStatus.pending
              ? 'Pending Verification'
              : null);
      effectiveErrorStyle =
          validationText?.status == FieldValidationStatus.pending
              ? effectiveErrorStyle.copyWith(color: Colors.red)
              : effectiveErrorStyle;
      switch (validationText?.status) {
        case null:
        case FieldValidationStatus.error:
          errorBorder = null;
          break;
        case FieldValidationStatus.pending:
          errorBorder = const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          );
          break;
        case FieldValidationStatus.success:
          errorBorder = const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          );
          break;
      }
    } else {
      errorBorder = null;
      effectiveErrorText = null;
    }

    final defaultInputBorder = widget.border ??
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey),
        );

    Widget result = Padding(
      padding: widget.canError
          ? (hasValidationState &&
                  effectiveErrorText == null &&
                  !widget.withCounterText
              ? const EdgeInsets.only(bottom: 18)
              : const EdgeInsets.only(bottom: 5))
          : EdgeInsets.zero,
      child: ValueListenableBuilder<bool>(
          valueListenable: _hasFocusListener,
          builder: (context, hasFocus, _) {
            return ValueListenableBuilder<bool>(
              valueListenable: _obscureNotifier,
              builder: (_, bool isObscured, __) {
                return TextField(
                  controller: _controller,
                  onChanged: _onChanged,
                  onSubmitted: _onSubmitted,
                  onTap: widget.onTap,
                  keyboardType: widget.inputType,
                  textInputAction: widget.inputAction,
                  inputFormatters: widget.inputFormatters,
                  showCursor: widget.showCursor,
                  autocorrect: widget.autocorrect,
                  autofocus: widget.autofocus,
                  readOnly: widget.readOnly,
                  enabled: widget.enabled,
                  enableSuggestions: widget.enableSuggestions,
                  obscureText: widget.obscureText && isObscured,
                  minLines: widget.minLines,
                  maxLines: widget.maxLines,
                  maxLength: widget.maxLength,
                  style: effectiveStyle,
                  textAlign: widget.textAlign,
                  focusNode: _effectiveFocusNode,
                  textCapitalization: widget.textCapitalization,
                  decoration: InputDecoration(
                    isDense: false,
                    filled: true,
                    fillColor: Colors.white,
                    hintText: decoration?.hintText,
                    hintStyle: effectiveHintStyle,
                    focusedBorder:
                        widget.bordered ? defaultInputBorder : InputBorder.none,
                    border:
                        widget.bordered ? defaultInputBorder : InputBorder.none,
                    enabledBorder:
                        widget.bordered ? defaultInputBorder : InputBorder.none,
                    disabledBorder:
                        widget.bordered ? defaultInputBorder : InputBorder.none,
                    counterText: widget.withCounterText ? null : '',
                    counterStyle: const TextStyle(fontSize: 12),
                    errorText: effectiveErrorText,
                    errorStyle: effectiveErrorStyle,
                    errorMaxLines: 1,
                    errorBorder: errorBorder,
                    focusedErrorBorder: errorBorder,
                    prefixIconConstraints: const BoxConstraints(),
                    prefixIcon: decoration?.prefixIcon != null
                        ? Padding(
                            padding: const EdgeInsetsDirectional.only(
                              start: 18,
                              end: 12,
                            ),
                            child: CircleAvatar(
                              radius: 19,
                              backgroundColor: hasFocus
                                  ? validationText != null
                                      ? Colors.red
                                      : Colors.grey
                                  : Colors.blueGrey,
                              child: Icon(
                                decoration!.prefixIcon,
                                color: hasFocus ? Colors.white : Colors.grey,
                                size: 18,
                              ),
                            ),
                          )
                        : decoration?.isPrefixInsideBox == false &&
                                decoration?.prefixWidth != null &&
                                decoration?.prefix != null
                            ? SizedBox(width: decoration?.prefixWidth)
                            : decoration?.prefix,
                    suffixIconConstraints: const BoxConstraints(),
                    suffixIcon: ValueListenableSelector<TextEditingValue, bool>(
                      valueListenable: _controller,
                      selector: (TextEditingValue value) =>
                          value.text.isNotEmpty,
                      builder: (_, bool isTextNotEmpty, child) {
                        final shouldShowSuffixIcon = isTextNotEmpty ||
                            validationText != null ||
                            suffix != null ||
                            widget.withClearButton ||
                            widget.obscureText;

                        if (!shouldShowSuffixIcon) {
                          return widget.textAlign != TextAlign.end
                              ? const SizedBox()
                              : const SizedBox(width: 12);
                        }
                        return _AdvTextFieldSuffixWidget(
                          isTextNotEmpty: isTextNotEmpty,
                          validationText: validationText,
                          obscureText: widget.obscureText,
                          obscureNotifier: _obscureNotifier,
                          withClearButton: widget.withClearButton,
                          onClearText: () => _controller.clear(),
                          suffix: suffix,
                          withValidator: widget.withValidator,
                        );
                      },
                    ),
                  ),
                );
              },
            );
          }),
    );

    if (decoration?.isPrefixInsideBox == false && decoration?.prefix != null) {
      result = Stack(
        children: <Widget>[
          result,
          Positioned(
            top: 0,
            left: 0,
            height: kMinInteractiveDimension,
            child: decoration!.prefix!,
          ),
        ],
      );
    }

    final labelText = decoration?.labelText;
    if (labelText != null) {
      result = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _AdvTextFieldLabelWidget(
            labelText: labelText,
            isRequired: decoration?.isRequired == true,
          ),
          result,
        ],
      );
    }

    return result;
  }

  late final TextEditingController _controller;
  late final ValueNotifier<bool> _hasFocusListener =
      autoDispose(ValueNotifier<bool>(false));
  late final ValueNotifier<bool> _obscureNotifier =
      autoDispose(ValueNotifier<bool>(true));

  @override
  void initState() {
    super.initState();
    _setTextFromValue();
    _controller = autoDispose(TextEditingController.fromValue(
      _getFormattedValue(TextEditingValue.empty),
    ));
    _listenFocusNode();
  }

  @override
  void didUpdateWidget(AdvValueTextField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateObscureNotifier(oldWidget.obscureText, widget.obscureText);
    _updateFocusNode(oldWidget.focusNode);
    _updateText();
  }

  void _updateObscureNotifier(bool oldObscureText, bool newObscureText) {
    if (oldObscureText != newObscureText && !newObscureText) {
      // reset the obscure notifier
      _obscureNotifier.value = true;
    }
  }

  void _updateFocusNode(FocusNode? oldFocusNode) {
    if (oldFocusNode != widget.focusNode) {
      _unlistenFocusNode();
      _listenFocusNode();
    }
  }

  FocusNode? _focusNode;
  FocusNode get _effectiveFocusNode =>
      widget.focusNode ?? (_focusNode ??= autoDispose(FocusNode()));

  late ChangeNotifierListener _focusListener;
  void _listenFocusNode() {
    _focusListener = ChangeNotifierListener.select(
      target: _effectiveFocusNode,
      selector: (FocusNode notifier) => notifier.hasFocus,
      listener: _onFocusChanged,
    );
  }

  void _unlistenFocusNode() {
    _focusListener.cancel();
  }

  void _onFocusChanged(bool hasFocus) {
    _hasFocusListener.value = hasFocus;
    if (hasFocus && widget.clearOnTap) {
      _controller.clear();
    }
  }

  T? _value;
  late String _valueText;
  void _updateText() {
    if (_value != widget.value) {
      _setTextFromValue();
      _controller.value = _getFormattedValue();
    }
  }

  void _setTextFromValue() {
    _value = widget.value;
    _valueText =
        _value is T ? widget.valueConverter.fromValue(_value as T) : '';
  }

  TextEditingValue _getFormattedValue([TextEditingValue? oldValue]) {
    final oldEditignValue = oldValue ?? _controller.value;
    final newEditingValue = TextEditingValue(text: _valueText);
    return widget.inputFormatters?.fold<TextEditingValue>(
          newEditingValue,
          (TextEditingValue newValue, TextInputFormatter formatter) {
            return formatter.formatEditUpdate(oldEditignValue, newValue);
          },
        ) ??
        newEditingValue;
  }

  void _onChanged(String value) {
    final newValue = widget.valueConverter.toValue(value);
    if (_value == newValue) return;
    _value = newValue;
    widget.onChanged?.call(_value as T);
  }

  void _onSubmitted(String value) {
    if (_value is! T) return;
    widget.onSubmitted?.call(_value as T);
  }
}

class _AdvTextFieldLabelWidget extends StatelessWidget {
  const _AdvTextFieldLabelWidget({
    required this.labelText,
    required this.isRequired,
  });

  final String labelText;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    final labelStyle = Theme.of(context).inputDecorationTheme.labelStyle;
    final labelText =
        isRequired ? '${this.labelText} (Required)' : this.labelText;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Text(labelText, style: labelStyle),
    );
  }
}

class _AdvTextFieldSuffixWidget extends StatelessWidget {
  const _AdvTextFieldSuffixWidget({
    required this.isTextNotEmpty,
    required this.validationText,
    required this.obscureText,
    required this.obscureNotifier,
    required this.withClearButton,
    required this.onClearText,
    required this.suffix,
    required this.withValidator,
  }) : super(key: const Key('#adv-text-field-suffix-widget'));

  final bool isTextNotEmpty;
  final AdvValueTextFieldValidationText? validationText;
  final bool obscureText;
  final ValueNotifier<bool> obscureNotifier;
  final bool withClearButton;
  final bool withValidator;
  final VoidCallback onClearText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    final textFieldStateIcon = _textFieldStateIcon;
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: Padding(
        padding: obscureText || withClearButton
            ? EdgeInsets.zero
            : const EdgeInsets.only(right: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            if (withValidator && textFieldStateIcon != null) textFieldStateIcon,
            // we need to wrap with [ExcludeFocus]
            // so that when user presses next,
            // the next [AdvValueTextField] can get focused
            // note that this only works if [AdvValueTextField.inputAction]
            // is set to [TextInputAction.next]
            if (obscureText)
              ExcludeFocus(
                child: _ObscureButton(obscureNotifier: obscureNotifier),
              ),
            if (withClearButton)
              ExcludeFocus(
                child: _ClearButton(onPressed: onClearText),
              ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }

  Icon? get _textFieldStateIcon {
    final validationText = this.validationText;
    final successIcon = const Icon(
      Icons.check,
      color: Colors.green,
      size: 18,
    );
    if (validationText == null) {
      if (isTextNotEmpty) return successIcon;
      return null;
    }
    switch (validationText.status) {
      case FieldValidationStatus.error:
        return const Icon(
          Icons.error,
          color: Colors.red,
          size: 18,
        );
      case FieldValidationStatus.success:
        return successIcon;
      case FieldValidationStatus.pending:
        return const Icon(
          Icons.warning,
          color: Colors.grey,
          size: 18,
        );
    }
  }
}

class _ObscureButton extends StatelessWidget {
  const _ObscureButton({
    required this.obscureNotifier,
  }) : super(key: const Key('#adv-text-field-obscure-button'));

  final ValueNotifier<bool> obscureNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (_, bool isObscured, __) {
        return IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          constraints: const BoxConstraints(),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () => obscureNotifier.value = !obscureNotifier.value,
          icon: isObscured
              ? const Icon(Icons.visibility_off_rounded, color: Colors.grey)
              : const Icon(Icons.remove_red_eye, color: Colors.grey),
        );
      },
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({
    required this.onPressed,
  }) : super(key: const Key('#adv-text-field-clear-button'));

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      constraints: const BoxConstraints(),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onPressed: onPressed,
      icon: const Icon(
        Icons.close,
        color: Colors.grey,
        size: 24,
      ),
    );
  }
}
