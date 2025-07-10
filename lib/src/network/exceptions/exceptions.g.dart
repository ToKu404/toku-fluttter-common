// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exceptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      error: json['error'] as String? ?? '',
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
    };

ErrorResponseDetail _$ErrorResponseDetailFromJson(Map<String, dynamic> json) =>
    ErrorResponseDetail(
      userId: (json['userId'] as num?)?.toInt(),
      username: json['username'] as String? ?? '',
    );

Map<String, dynamic> _$ErrorResponseDetailToJson(
        ErrorResponseDetail instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
    };
