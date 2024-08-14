import 'package:http/http.dart';

class ExposedStreamMultipartFile extends MultipartFile {
  /// Creates a new [MultipartFile] from a chunked [Stream] of bytes.
  ///
  /// The length of the file in bytes must be known in advance. If it's not,
  /// read the data from the stream and use [MultipartFile.fromBytes] instead.
  ///
  /// [contentType] currently defaults to `application/octet-stream`, but in the
  /// future may be inferred from [filename].
  ExposedStreamMultipartFile(
    super.field,
    super.stream,
    super.length, {
    super.filename,
    super.contentType,
  }) : byteStream = stream;

  final Stream<List<int>> byteStream;
}
