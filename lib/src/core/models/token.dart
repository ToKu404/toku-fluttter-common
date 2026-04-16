import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class TokenModel {
  const TokenModel({
    this.accessToken,
    this.refreshToken,
    this.isVerified,
    this.userType,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => _$TokenModelFromJson(json);

  final String? accessToken;
  final String? refreshToken;
  final bool? isVerified;
  final String? userType;

  Map<String, dynamic> toJson() => _$TokenModelToJson(this);

  bool get isEmpty => [accessToken, refreshToken].every((token) => token == null || token.isEmpty);
}
