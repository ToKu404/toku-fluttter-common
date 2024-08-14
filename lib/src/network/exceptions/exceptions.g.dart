// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      code: json['code'] as String? ?? '',
      message: json['message'] as String? ?? '',
      detail: ErrorResponse._detailFromJson(json['detail']),
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'detail': ErrorResponse._detailToJson(instance.detail),
    };

ErrorResponseDetail _$ErrorResponseDetailFromJson(Map<String, dynamic> json) =>
    ErrorResponseDetail(
      userId: json['userId'] as int?,
      username: json['username'] as String? ?? '',
    );

Map<String, dynamic> _$ErrorResponseDetailToJson(
        ErrorResponseDetail instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
    };
