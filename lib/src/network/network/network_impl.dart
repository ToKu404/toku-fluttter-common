import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:http/http.dart';
// ignore: unnecessary_import
import 'package:http_parser/http_parser.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:toku_flutter_common/src/network/http/_http.dart';
import 'package:toku_flutter_common/src/network/network/exposed_stream_multipart_file.dart';
import 'package:toku_flutter_common/src/network/network/network.dart';

class NetworkImpl implements Network {
  @internal
  const NetworkImpl();

  @override
  Request createRequest({
    required String method,
    required Uri url,
    Encoding encoding = utf8,
    Map<String, String> headers = const <String, String>{},
    Map<String, dynamic>? body,
  }) {
    final request = Request(method, url)
      ..headers.addAll(headers)
      ..encoding = encoding;
    if (body != null) {
      request.body = json.encode(body);
    }
    return request;
  }

  @override
  Future<MultipartRequest> createMultipartRequest({
    required String method,
    required Uri url,
    Map<String, String> headers = const <String, String>{},
    Map<String, String>? fields,
    Map<String, XFile>? files,
  }) async {
    final request = MultipartRequest(method, url)..headers.addAll(headers);
    if (fields != null && fields.isNotEmpty) {
      request.fields.addAll(fields);
    }
    if (files != null && files.isNotEmpty) {
      for (final fieldName in files.keys) {
        final file = files[fieldName];
        if (file == null) continue;

        final stream = ByteStream(file.openRead());
        final length = await file.length();
        final filename = await _deriveFilename(file, fieldName);
        final contentType = await _deriveContentType(file, filename);

        final multipartFile = ExposedStreamMultipartFile(
          fieldName,
          stream,
          length,
          filename: filename,
          contentType: contentType,
        );
        request.files.add(multipartFile);
      }
    }
    return request;
  }

  @override
  Future<HttpResponse> getResponseFromStream(StreamedResponse response) {
    return HttpResponse.fromStream(response);
  }

  Future<String> _deriveFilename(XFile file, String fieldName) async {
    if (file.name.isNotEmpty) {
      return file.name;
    }
    if (file.path.isNotEmpty) {
      return path.basename(file.path);
    }
    final extensionFromMimeType = _extensionFromMimeType(file.mimeType);
    if (extensionFromMimeType != null) {
      return '$fieldName.$extensionFromMimeType';
    }

    try {
      final first = await file.openRead(0, 12).first;
      if (first.length >= 2 && first[0] == 0xFF && first[1] == 0xD8) {
        return '$fieldName.jpg';
      }
      if (first.length >= 4 &&
          first[0] == 0x89 &&
          first[1] == 0x50 &&
          first[2] == 0x4E &&
          first[3] == 0x47) {
        return '$fieldName.png';
      }
    } catch (_) {
      // Fall back to a generic filename when the byte header cannot be read.
    }

    return '$fieldName.bin';
  }

  String? _extensionFromMimeType(String? mimeType) {
    switch (mimeType?.toLowerCase()) {
      case 'image/jpeg':
        return 'jpg';
      case 'image/png':
        return 'png';
      case 'image/gif':
        return 'gif';
      case 'image/webp':
        return 'webp';
      case 'application/pdf':
        return 'pdf';
      default:
        return null;
    }
  }

  Future<MediaType?> _deriveContentType(XFile file, String filename) async {
    final rawMimeType = file.mimeType;
    if (rawMimeType != null && rawMimeType.isNotEmpty) {
      try {
        return MediaType.parse(rawMimeType);
      } catch (_) {
        // Ignore invalid mimeType and fallback to filename-based inference.
      }
    }

    final lowerFileName = filename.toLowerCase();
    if (lowerFileName.endsWith('.jpg') || lowerFileName.endsWith('.jpeg')) {
      return MediaType('image', 'jpeg');
    }
    if (lowerFileName.endsWith('.png')) {
      return MediaType('image', 'png');
    }

    try {
      final first = await file.openRead(0, 12).first;
      if (first.length >= 2 && first[0] == 0xFF && first[1] == 0xD8) {
        return MediaType('image', 'jpeg');
      }
      if (first.length >= 4 &&
          first[0] == 0x89 &&
          first[1] == 0x50 &&
          first[2] == 0x4E &&
          first[3] == 0x47) {
        return MediaType('image', 'png');
      }
    } catch (_) {
      // Leave content type unset when it cannot be inferred.
    }

    return null;
  }
}
