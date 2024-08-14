part of http;

@Freezed(
  equal: false,
  copyWith: false,
  toStringOverride: false,
  makeCollectionsUnmodifiable: false,
  map: FreezedMapOptions.none,
  when: FreezedWhenOptions(
    when: true,
    whenOrNull: false,
    maybeWhen: false,
  ),
)
class HttpRequestBody with _$HttpRequestBody {
  const factory HttpRequestBody.basic([
    Map<String, dynamic>? body,
  ]) = _BasicHttpRequestBody;

  const factory HttpRequestBody.multipart({
    Map<String, String>? fields,

    /// The key is the name of the file field, the value is the file to be uploaded.
    ///
    /// We use [XFile] here instead of `File` because it is not supported on web.
    Map<String, XFile>? files,
  }) = _MultipartHttpRequestBody;

  static const HttpRequestBody empty = HttpRequestBody.basic();
}
