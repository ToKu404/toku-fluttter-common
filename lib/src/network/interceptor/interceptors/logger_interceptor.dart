import 'dart:convert';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:toku_flutter_common/network.dart';
import 'package:toku_flutter_common/src/core/models/result.dart';

class LoggerInterceptor extends Interceptor {
  const LoggerInterceptor();

  static String _prettyJsonFromMap(Map<String, dynamic> map) => const JsonEncoder.withIndent('  ').convert(map);
  static Object _prettyJsonFromString(String json) {
    try {
      final Map<String, dynamic> decoded = jsonDecode(json) as Map<String, dynamic>;
      return _prettyJsonFromMap(decoded);
    } on FormatException {
      return json;
    }
  }

  @override
  Future<Result<HttpResponse>> intercept(InterceptorChain chain) async {
    final outgoingLogBuffer = StringBuffer()
      ..writeln('Outgoing [${chain.request.method}] ${chain.request.url}')
      ..writeln('Request Headers: ${_prettyJsonFromMap(chain.request.headers)}');
    final request = chain.request;
    if (request is Request && request.bodyBytes.isNotEmpty) {
      outgoingLogBuffer.writeln('Body: ${_prettyJsonFromString(request.body)}');
    } else if (request is MultipartRequest) {
      outgoingLogBuffer
        ..writeln('Fields: ${_prettyJsonFromMap(request.fields)}')
        ..writeln('Files: ${request.files}');
    }

    log(
      outgoingLogBuffer.toString(),
      name: 'LoggerInterceptor',
    );

    final response = await chain.proceed(chain.request);

    response.when(
      success: (HttpResponse data) {
        final bodyJson = data.bodyJson;
        final resultBody = bodyJson != null
            ? bodyJson is List
                ? bodyJson
                : _prettyJsonFromMap(bodyJson)
            : null;
        log(
          'Incoming [${chain.request.method}] ${chain.request.url}\n'
          'Response Headers: ${_prettyJsonFromMap(data.headers)}\n'
          'Status Code: ${data.statusCode}\n'
          'Reason Phrase: ${data.reasonPhrase}\n'
          'Body: $resultBody',
          name: 'LoggerInterceptor',
        );
      },
      error: (Exception e) {
        final errorLogBuffer = StringBuffer()
          ..writeln('Incoming failure [${chain.request.method}] ${chain.request.url}')
          ..writeln('Request Headers: ${_prettyJsonFromMap(chain.request.headers)}');
        if (e is ErrorResponseException) {
          errorLogBuffer
            ..writeln('Error (${e.statusCode}): ${_prettyJsonFromMap(e.errorResponse.toJson())}')
            ..writeln('Response Headers: ${_prettyJsonFromMap(e.responseHeaders!)}');
          // ..writeln('Response Body: ${_prettyJsonFromMap(e.responseRawJson!)}');
        }
        log(
          errorLogBuffer.toString(),
          name: 'LoggerInterceptor',
          error: e,
          stackTrace: StackTrace.current,
        );
      },
    );

    return response;
  }
}
