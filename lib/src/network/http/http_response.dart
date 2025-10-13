part of http;

class HttpResponse extends Response {
  // --- Konstruktor dan factory (tidak ada perubahan) ---
  HttpResponse(
    super.body,
    super.statusCode, {
    super.request,
    super.headers,
    super.isRedirect,
    super.persistentConnection,
    super.reasonPhrase,
  });

  HttpResponse.bytes(
    List<int> bodyBytes,
    int statusCode, {
    BaseRequest? request,
    Map<String, String> headers = const <String, String>{},
    bool isRedirect = false,
    bool persistentConnection = true,
    String? reasonPhrase,
  }) : super.bytes(
          bodyBytes,
          statusCode,
          request: request,
          headers: headers,
          isRedirect: isRedirect,
          persistentConnection: persistentConnection,
          reasonPhrase: reasonPhrase,
        );

  static Future<HttpResponse> fromStream(StreamedResponse response) async {
    final body = await response.stream.toBytes();
    return HttpResponse.bytes(
      body,
      response.statusCode,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  // --- Logika Cerdas (Bagian yang Diubah) ---

  bool? _isJsonResponse;
  bool get isJsonResponse {
    if (_isJsonResponse != null) return _isJsonResponse!;
    final headers = this.headers.toIgnoreCase();
    final contentType = headers['content-type'];
    return _isJsonResponse =
        contentType?.toLowerCase().contains('application/json') == true;
  }

  Map<String, dynamic>? _bodyJson;
  Map<String, dynamic>? get bodyJson {
    if (_bodyJson != null) return _bodyJson!;
    if (!isJsonResponse) return null;

    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return _bodyJson = decoded;
      }
      // Penanganan Array: bungkus dalam map agar konsisten
      if (decoded is List) {
        return _bodyJson = {'data': decoded};
      }
    } catch (e) {
      // Jika JSON tidak valid, anggap tidak ada body
      return null;
    }
    return null;
  }

  bool? _hasBodyResponse;
  bool get hasBodyResponse => _hasBodyResponse ?? bodyResponse != null;

  Object? _bodyResponse;
  /// Mengembalikan nilai dari kunci "data" jika ada.
  /// Jika tidak, mengembalikan seluruh body JSON.
  Object? get bodyResponse {
    if (_bodyResponse != null) return _bodyResponse!;
    final json = this.bodyJson;
    if (json == null) return null;

    // Prioritas 1: Cek apakah ada kunci 'data'
    if (json.containsKey('data')) {
      _hasBodyResponse = true;
      return _bodyResponse = json['data'];
    }

    // Prioritas 2: Jika tidak ada 'data', kembalikan seluruh body,
    // asalkan itu bukan format error.
    if (!json.containsKey('error') && !json.containsKey('message')) {
      _hasBodyResponse = true;
      return _bodyResponse = json;
    }

    _hasBodyResponse = false;
    return null;
  }

  bool? _hasBodyError;
  bool get hasBodyError => _hasBodyError ?? bodyError != null;

  Map<String, dynamic>? _bodyError;
  /// Mengembalikan nilai dari kunci "error" jika ada.
  /// Jika tidak, mengembalikan seluruh body JSON jika ada kunci "message".
  Map<String, dynamic>? get bodyError {
    if (_bodyError != null) return _bodyError!;
    final json = this.bodyJson;
    if (json == null) return null;

    // Prioritas 1: Cek apakah ada kunci 'error' dan nilainya adalah Map
    if (json.containsKey('error') && json['error'] is Map<String, dynamic>) {
      _hasBodyError = true;
      return _bodyError = json['error'] as Map<String, dynamic>;
    }

    // Prioritas 2: Jika tidak ada, cek apakah ada kunci 'message' di level atas
    if (json.containsKey('message')) {
      _hasBodyError = true;
      return _bodyError = json;
    }

    _hasBodyError = false;
    return null;
  }
}