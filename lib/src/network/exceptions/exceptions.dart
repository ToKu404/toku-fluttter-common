import 'package:equatable/equatable.dart';
import 'package:kartjis_mobile_common/src/core/anotations/_annotations.dart';
import 'package:kartjis_mobile_common/src/core/exceptions/_exceptions.dart';

part 'exceptions.g.dart';

class NoConnectionException implements Exception {
  @override
  String toString() => 'No Connection';
}

class BadResponseFormatException implements Exception {
  @override
  String toString() => 'Bad Response Format';
}

class UnexpectedResponseFormatException implements Exception {
  @override
  String toString() => 'Unexpected Response Format';
}

class ErrorResponseException implements Exception {
  const ErrorResponseException({
    required this.statusCode,
    this.responseHeaders,
    this.responseRawJson,
    required this.errorResponse,
  });

  final int statusCode;

  /// This field is only available on debug mode.
  ///
  /// **DO NOT** access this in other than debug mode.
  final Map<String, String>? responseHeaders;

  /// This field is only available on debug mode.
  ///
  /// **DO NOT** access this in other than debug mode.
  final Map<String, dynamic>? responseRawJson;

  final ErrorResponse errorResponse;

  bool get isInvalidGrant => errorResponse.message == 'invalid_grant';

  bool get isInvalidToken => errorResponse.message == 'invalid_token';

  @override
  String toString() => errorResponse.message;
}

@jsonable
class ErrorResponse extends Equatable {
  const ErrorResponse({
    this.code = '',
    this.message = '',
    this.detail,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  static const ErrorResponse empty = ErrorResponse();

  final String code;
  final String message;

  @JsonKey(
    fromJson: _detailFromJson,
    toJson: _detailToJson,
  )
  final Object? detail;
  static Object? _detailToJson(Object? detail) =>
      detail is ErrorResponseDetail ? detail.toJson() : detail;
  static Object? _detailFromJson(Object? detail) {
    if (detail is Map<String, dynamic>) {
      return ErrorResponseDetail.fromJson(detail);
    }
    return detail;
  }

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  bool get isEmpty => this == empty;

  @override
  List<Object?> get props => [code, message, detail];
}

@jsonable
class ErrorResponseDetail extends Equatable {
  const ErrorResponseDetail({
    this.userId,
    this.username = '',
  });

  factory ErrorResponseDetail.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseDetailFromJson(json);

  static const ErrorResponseDetail empty = ErrorResponseDetail();

  final int? userId;
  final String username;

  Map<String, dynamic> toJson() => _$ErrorResponseDetailToJson(this);

  bool get isEmpty => this == empty;

  @override
  List<Object?> get props => [userId, username];
}

//

class HttpException extends CustomException {
  HttpException(super.message, {this.statusCode});

  final int? statusCode;
}
