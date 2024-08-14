part of http;

enum HttpMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  delete('DELETE'),
  patch('PATCH'),
  ;

  const HttpMethod(this._value);

  final String _value;
}
