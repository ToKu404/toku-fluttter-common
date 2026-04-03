import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TokenModel {
  TokenModel({required this.accessToken, required this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

  final String accessToken;
  final String refreshToken;

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);
}
