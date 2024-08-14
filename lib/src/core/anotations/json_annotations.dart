import 'package:json_annotation/json_annotation.dart';

export 'package:json_annotation/json_annotation.dart';

const JsonSerializable jsonDecodable = JsonSerializable(
  createFactory: true,
  createToJson: false,
);
const JsonSerializable jsonable = JsonSerializable(
  createFactory: true,
  createToJson: true,
);
const JsonSerializable jsonEncodable = JsonSerializable(
  createFactory: false,
  createToJson: true,
);
