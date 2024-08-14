part of http;

enum HttpContentType {
  json('application/json'),
  urlEncoded('application/x-www-form-urlencoded'),
  formData('multipart/form-data'),
  ;

  const HttpContentType(this._headerValue);
  final String _headerValue;
}
