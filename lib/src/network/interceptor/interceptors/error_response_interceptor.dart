import 'package:flutter/foundation.dart';
import 'package:toku_flutter_common/core.dart';
import 'package:toku_flutter_common/network.dart';

class ErrorResponseInterceptor extends Interceptor {
  const ErrorResponseInterceptor();

  @override
  Future<Result<HttpResponse>> intercept(InterceptorChain chain) {
    return chain.proceed(chain.request).andThenAsync((HttpResponse data) {
      final errorJson = data.bodyError?['error'];
      final errorMessage = errorJson is Map<String, dynamic> ? errorJson['message'] as String? : null;

      if (data.statusCode == 403 || data.statusCode == 401) {
        final errorResponseException = ErrorResponseException(
          statusCode: data.statusCode,
          responseHeaders: kDebugMode ? data.headers : null,
          errorResponse: ErrorResponse(message: errorMessage ?? 'Session expired'),
        );

        return Result<HttpResponse>.error(errorResponseException);
      } else if (!data.isSuccess) {
        return Result.error(
          HttpCodeException(
            statusCode: data.statusCode,
            reasonPhrase: errorMessage ?? data.bodyError?['message'] ?? data.reasonPhrase,
          ),
        );
      }
      return Result<HttpResponse>.success(data);
    });
  }
}

class HttpCodeException implements Exception {
  HttpCodeException({
    required this.statusCode,
    this.reasonPhrase,
  });

  final int statusCode;
  final String? reasonPhrase;

  @override
  String toString() => '$statusCode: ${reasonPhrase ?? 'Error'}';
}
