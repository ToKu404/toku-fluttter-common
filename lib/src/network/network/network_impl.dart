import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:toku_flutter_common/src/network/http/_http.dart';
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
    Map<String, List<XFile>>? multifiles,
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

        // Extract only the filename from the full path
        final filename = file.path.split('/').last.split('\\').last;

        // Get content type from mime type
        final contentType = file.mimeType != null ? MediaType.parse(file.mimeType!) : null;

        final multipartFile = MultipartFile(
          fieldName,
          stream,
          length,
          filename: filename,
          contentType: contentType,
        );

        request.files.add(multipartFile);
      }
    }

    if (multifiles != null && multifiles.isNotEmpty) {
      for (final fieldName in multifiles.keys) {
        final fileList = multifiles[fieldName];

        if (fileList == null || fileList.isEmpty) continue;

        for (final file in fileList) {
          final stream = ByteStream(file.openRead());
          final length = await file.length();

          // Extract only the filename from the full path
          final filename = file.path.split('/').last.split('\\').last;

          // Get content type from mime type
          final contentType = file.mimeType != null ? MediaType.parse(file.mimeType!) : null;

          final multipartFile = MultipartFile(
            fieldName,
            stream,
            length,
            filename: filename,
            contentType: contentType,
          );

          request.files.add(multipartFile);
        }
      }
    }

    return request;
  }

  @override
  Future<HttpResponse> getResponseFromStream(StreamedResponse response) {
    return HttpResponse.fromStream(response);
  }
}
