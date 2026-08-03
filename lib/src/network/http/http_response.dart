// Salin dan tempel seluruh kode ini ke dalam file HttpResponse Anda.
// Pastikan nama file sesuai dengan yang Anda 'part' di file utama.

part of http; // <-- Ini tetap ada sesuai permintaan Anda

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

  // --- Logika Final yang Sudah Diperbaiki ---

  /// Helper untuk mengecek apakah status kode menunjukan sukses (2xx).
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Helper untuk mengecek apakah content-type adalah JSON.
  bool get isJsonResponse {
    final contentType = headers['content-type'];
    return contentType?.toLowerCase().contains('application/json') == true;
  }

  /// Mem-parsing body menjadi Map<String, dynamic> dengan aman.
  /// Juga menangani JSON yang berakar pada array `[...]`.
  Map<String, dynamic>? _bodyJson;
  Map<String, dynamic>? get bodyJson {
    if (_bodyJson != null) return _bodyJson!;
    if (!isJsonResponse || body.isEmpty) return null;

    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        return _bodyJson = decoded;
      }
      // Jika root JSON adalah array, bungkus dalam map agar konsisten
      if (decoded is List) {
        return _bodyJson = {'data': decoded};
      }
    } catch (e) {
      // Jika JSON tidak valid, anggap tidak ada body
      return null;
    }
    return null;
  }

  /// Mengembalikan data HANYA JIKA status kode sukses.
  ///
  /// Backend ini punya dua konvensi envelope yang berbeda:
  /// - `{success, data, errors}` (V2Body dkk) -> `data` murni berisi payload,
  ///   jadi di-unwrap.
  /// - `{status, data, pagination, message}` (Body/PagedBody legacy) ->
  ///   `data` sejajar dengan `pagination`/`status`, dan model pemanggilnya
  ///   memang didesain menerima seluruh body ini (bukan cuma isi `data`),
  ///   jadi TIDAK di-unwrap.
  ///
  /// Dibedakan lewat keberadaan kunci `success`: hanya envelope yang
  /// mendeklarasikan `success` yang di-unwrap ke `data`.
  Object? _bodyResponse;
  Object? get bodyResponse {
    if (_bodyResponse != null) return _bodyResponse!;
    // Data hanya valid jika request sukses
    if (!isSuccess) return null;

    final json = bodyJson;
    if (json == null) return null;

    if (json.containsKey('success') && json.containsKey('data')) {
      return _bodyResponse = json['data'];
    }

    return _bodyResponse = json;
  }

  /// Mengecek apakah ada data sukses yang valid.
  bool get hasBodyResponse => bodyResponse != null;

  /// Mengembalikan error HANYA JIKA status kode GAGAL.
  /// Mengembalikan seluruh body JSON sebagai detail error.
  Map<String, dynamic>? _bodyError;
  Map<String, dynamic>? get bodyError {
    if (_bodyError != null) return _bodyError!;
    // Error hanya valid jika request gagal
    if (isSuccess) return null;

    // Untuk error, kembalikan saja seluruh body JSON
    return _bodyError = bodyJson;
  }

  /// Mengecek apakah ada data error yang valid.
  bool get hasBodyError => bodyError != null;
}
