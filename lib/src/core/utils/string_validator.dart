import 'package:injectable/injectable.dart';

import 'package:kartjis_mobile_common/network.dart' show NoConnectionException;

abstract class IsValid {
  static const IsValid empty = _IntValueIsValid._(0, 'empty');
  static const IsValid tooLow = _IntValueIsValid._(1, 'tooLow');
  static const IsValid tooHigh = _IntValueIsValid._(2, 'tooHigh');
  static const IsValid tooShort = _IntValueIsValid._(3, 'tooShort');
  static const IsValid tooLong = _IntValueIsValid._(4, 'tooLong');
  static const IsValid containsWhitespace = _IntValueIsValid._(5, 'containsWhitespace');
  static const IsValid notEqual = _IntValueIsValid._(6, 'notEqual');
  static const IsValid notEmail = _IntValueIsValid._(7, 'notEmail');
  static const IsValid notPhoneNumber = _IntValueIsValid._(8, 'notPhoneNumber');
  static const IsValid notUsername = _IntValueIsValid._(9, 'notUsername');
  static const IsValid notUsernameChar = _IntValueIsValid._(10, 'notUsernameChar');
  static const IsValid notDecimalNumbersOnly = _IntValueIsValid._(11, 'notDecimalNumbersOnly');
  static const IsValid notAsciiOnly = _IntValueIsValid._(12, 'notAsciiOnly');
  static const IsValid notLettersOnly = _IntValueIsValid._(13, 'notLettersOnly');
  static const IsValid notNumbersOnly = _IntValueIsValid._(14, 'notNumbersOnly');
  static const IsValid noInternetConnection = _IntValueIsValid._(15, 'noInternetConnection');

  static IsValid string(String value) => StringValueIsValid._(value);

  /// Returns [IsValid.noInternetConnection] when [error] is [NoConnectionException],
  /// otherwise returns [IsValid.string] with the [Object.toString] from the error.
  static IsValid fromError(Exception error) {
    return error is NoConnectionException ? IsValid.noInternetConnection : IsValid.string(error.toString());
  }
}

typedef _IntValueIsValid = _CustomValueIsValid<int>;
typedef StringValueIsValid = _CustomValueIsValid<String>;

class _CustomValueIsValid<T extends Object> implements IsValid {
  const _CustomValueIsValid._(this.value, [this._debugName]);

  final T value;
  final String? _debugName;

  @override
  String toString() => '$T(${_debugName ?? value})';
}

extension IsValidBool on IsValid? {
  bool get valid => this == null;
}

typedef StringValidatorCallback = IsValid? Function(String value);

const Named optionalStringValidator = Named('optionalStringValidator');

/// Validator for string values.
/// [StringValidator.test] will return [IsValid] if the input fails to satisfy
/// any of the [StringValidatorCallback]s added, otherwise it will return null.
///
/// Example:
/// ```dart
/// final StringValidator accountNumberValidator = StringValidator().forNumbersOnly.withLength(min: 11, max: 11);
/// final IsValid? isAccountNumberValid = accountNumberValidator.test('12345678901');
/// final bool isValid = isAccountNumberValid.valid;
/// print(isValid); // true
/// ```
@injectable
class StringValidator {
  factory StringValidator() => StringValidator.create(
        validators: <StringValidatorCallback>[_isNotEmpty],
        isOptional: false,
      );

  StringValidator.create({
    required List<StringValidatorCallback> validators,
    required bool isOptional,
  })  : _validators = validators,
        _isOptional = isOptional;

  final bool _isOptional;

  final List<StringValidatorCallback> _validators;

  StringValidator add(StringValidatorCallback callback) {
    assert(
      !_validators.contains(callback),
      'Validator $callback already exists.',
    );
    _validators.add(callback);
    return this;
  }

  /// Removes all registered [StringValidatorCallback]s.
  void reset() {
    _validators.clear();
    _hasMinLength = false;
    _hasMaxLength = false;
  }

  bool _hasMinLength = false;

  /// Validator for minimum length of string. [min] must be greater than 0.
  ///
  /// [minLength] cannot be added more than once, otherwise it will throw [AssertionError] on debug mode.
  StringValidator minLength(int min) {
    assert(
      min > 0,
      'Min length must be greater than zero.',
    );
    assert(
      !_hasMinLength,
      'MinLength validator already exists.',
    );
    if (_hasMinLength) return this;
    _hasMinLength = true;
    return add((String value) => _minLength(value, min));
  }

  bool _hasMaxLength = false;

  /// Validator for maximum length of string. [max] must be greater than 0.
  ///
  /// [maxLength] cannot be added more than once, otherwise it will throw [AssertionError] on debug mode.
  StringValidator maxLength(int max) {
    assert(
      max > 0,
      'Max length must be greater than zero.',
    );
    assert(
      !_hasMaxLength,
      'MaxLength validator already exists.',
    );
    if (_hasMaxLength) return this;
    _hasMaxLength = true;
    return add((String value) => _maxLength(value, max));
  }

  /// Validator for minimum and maximum length of string. [min] and [max] must be greater than 0.
  ///
  /// [withLength] cannot be added more than once, otherwise it will throw [AssertionError] on debug mode.
  StringValidator withLength({required int min, required int max}) => minLength(min).maxLength(max);

  StringValidator withEither(
    StringValidatorCallback first, {
    required StringValidatorCallback or,
  }) {
    return add((String value) {
      final firstResult = first(value);
      final orResult = or(value);
      if (firstResult == null || orResult == null) return null;
      return firstResult;
    });
  }

  StringValidator get withoutWhitespace {
    assert(
      !_validators.contains(_isWithoutWhitespace),
      'WithoutWhitespace validator already exists.',
    );
    return add(_isWithoutWhitespace);
  }

  static const StringValidatorCallback isNotEmpty = _isNotEmpty;

  static const StringValidatorCallback isValidEmail = _isValidEmail;

  /// Validator for email addresses that are valid according to the RFC 5322 standard.
  ///
  /// See [this wikipedia article](https://en.wikipedia.org/wiki/Email_address) for details.
  StringValidator get forEmail {
    assert(
      !_validators.contains(_isValidEmail),
      'Email validator already exists.',
    );
    return add(_isValidEmail);
  }

  /// Validator for Philippine 10 digit phone numbers (without 0 prefix) or
  /// 11 digit phone numbers (with 0 prefix). Phone number should start with 9 or 09.
  ///
  /// Valid formats:
  /// - 9XXXXXXXXX
  /// - 09XXXXXXXXX
  /// - 09XX XXX XXXX
  /// - 0 9XX XXX XXXX
  /// - 09XX-XXX-XXXX
  /// - 0-9XX-XXX-XXXX
  StringValidator get forPhoneNumber {
    assert(
      !_validators.contains(_isValidPhoneNumber),
      'PhoneNumber validator already exists.',
    );
    return add(_isValidPhoneNumber);
  }

  static const StringValidatorCallback isValidUsername = _isValidUsername;

  StringValidator get forUsername {
    assert(
      !_validators.contains(_isValidUsername),
      'Username validator already exists.',
    );
    return add(_isValidUsername);
  }

  StringValidator get forUsernameChar {
    assert(
      !_validators.contains(_isValidUsernameChar),
      'UsernameChar validator already exists.',
    );
    return add(_isValidUsernameChar);
  }

  /// Validator for positive integers and positive decimals only
  StringValidator get forDecimalNumbersOnly {
    assert(
      !_validators.contains(_isValidDecimalNumber),
      'DecimalNumber validator already exists.',
    );
    return add(_isValidDecimalNumber);
  }

  /// Validator for ASCII characters (0-127 char codes) and spanish characters only (áéíñóúüÁÉÍÑÓÚÜ)
  StringValidator get forAsciiOnly {
    assert(
      !_validators.contains(_isValidAscii),
      'AsciiOnly validator already exists.',
    );
    return add(_isValidAscii);
  }

  /// Validator for alphabets (a-z A-Z) and whitespaces only
  StringValidator get forLettersOnly {
    assert(
      !_validators.contains(_isValidNumbers),
      'Cannot mix LettersOnly with NumbersOnly.',
    );
    assert(
      !_validators.contains(_isValidLetters),
      'LettersOnly validator already exists.',
    );
    return add(_isValidLetters);
  }

  /// Validator for numbers (0-9) only
  StringValidator get forNumbersOnly {
    assert(
      !_validators.contains(_isValidLetters),
      'Cannot mix NumbersOnly with LettersOnly.',
    );
    assert(
      !_validators.contains(_isValidNumbers),
      'NumbersOnly validator already exists.',
    );
    return add(_isValidNumbers);
  }

  /// Validate [value] with previously added [StringValidatorCallback]s
  IsValid? test(String? value) {
    assert(_validators.isNotEmpty, 'Validator callback cannot be empty.');
    final val = value ?? '';
    if (_isOptional && val.isEmpty) return null;

    IsValid? isValid;
    for (final callback in _validators) {
      isValid = callback(val);
      if (isValid != null) break;
    }
    return isValid;
  }
}

IsValid? _isNotEmpty(String value) => value.isEmpty ? IsValid.empty : null;

IsValid? _minLength(String value, int min) {
  if (value.length < min) return IsValid.tooShort;
  return null;
}

IsValid? _maxLength(String value, int max) {
  if (value.length > max) return IsValid.tooLong;
  return null;
}

IsValid? _isWithoutWhitespace(String value) {
  if (value.contains(' ')) return IsValid.containsWhitespace;
  return null;
}

final RegExp _emailRegEx1 = RegExp(r"""^[a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~]+(?:[.]?[a-zA-Z0-9!#$%&'*+\-\/=?^_`{|}~]+)*""");
final RegExp _emailRegEx2 = RegExp(r'''@{1}[a-zA-Z0-9]*(?:[-]*[.]?[a-zA-Z0-9])*[.][a-zA-Z0-9]+$''');

/// based on https://en.wikipedia.org/wiki/Email_address#:~:text=The%20format%20of%20an%20email,3696%20and%20the%20associated%20errata
IsValid? _isValidEmail(String value) {
  final localPart = _emailRegEx1.firstMatch(value);
  final domainPart = _emailRegEx2.firstMatch(value);
  if (localPart == null || domainPart == null) return IsValid.notEmail;

  final localPartString = value.substring(localPart.start, localPart.end);
  final domainPartString = value.substring(domainPart.start, domainPart.end);

  final localBytes = localPartString.codeUnits;

  ///The maximum total length of the local-part of an email address is 64 octets
  ///The domain name part of an email address has to conform to strict guidelines:
  ///it must match the requirements for a hostname, a list of dot-separated DNS labels,
  ///each label being limited to a length of 63 characters
  if (localBytes.length > 64 || domainPartString.length > 64) return IsValid.notEmail;

  return (localPartString + domainPartString) != value ? IsValid.notEmail : null;
}

final RegExp _phoneNumberRegExp = RegExp(r'^9\d{9}$');

IsValid? _isValidPhoneNumber(String value) {
  if (!_phoneNumberRegExp.hasMatch(value)) {
    return IsValid.notPhoneNumber;
  }
  return null;
}

final RegExp _usernameRegExp = RegExp(r'^(?![.])[a-zA-Z0-9_.]+(?<![.])$');

IsValid? _isValidUsername(String value) {
  if (!_usernameRegExp.hasMatch(value)) {
    return IsValid.notUsername;
  }
  return null;
}

final RegExp _usernameCharRegExp = RegExp(r'^[a-zA-Z0-9._]*$');

IsValid? _isValidUsernameChar(String value) {
  if (!_usernameCharRegExp.hasMatch(value)) {
    return IsValid.notUsernameChar;
  }
  return null;
}

final RegExp _decimalNumbersOnlyRegExp = RegExp(r'^(\d*\.)?\d+$|^(\d*\,)?\d+$');

IsValid? _isValidDecimalNumber(String value) {
  if (!_decimalNumbersOnlyRegExp.hasMatch(value)) {
    return IsValid.notDecimalNumbersOnly;
  }
  return null;
}

final RegExp _asciiOnlyRegExp = RegExp(r'^[\x00-\x7FáéíñóúüÁÉÍÑÓÚÜ]+$');

IsValid? _isValidAscii(String value) {
  if (!_asciiOnlyRegExp.hasMatch(value)) {
    return IsValid.notAsciiOnly;
  }
  return null;
}

final RegExp _lettersOnlyRegExp = RegExp(r'^[A-Z a-z]+$');

IsValid? _isValidLetters(String value) {
  if (!_lettersOnlyRegExp.hasMatch(value)) {
    return IsValid.notLettersOnly;
  }
  return null;
}

final RegExp _numbersOnlyRegExp = RegExp(r'^[0-9]+$');

IsValid? _isValidNumbers(String value) {
  if (!_numbersOnlyRegExp.hasMatch(value)) {
    return IsValid.notNumbersOnly;
  }
  return null;
}
