import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:kartjis_mobile_common/src/network/http/_http.dart';
import 'package:kartjis_mobile_common/src/network/network/network_impl.dart';


@lazySingleton
abstract class Network {
  @factoryMethod
  const factory Network() = NetworkImpl;

  Request createRequest({
    required String method,
    required Uri url,
    Encoding encoding,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  });

  Future<MultipartRequest> createMultipartRequest({
    required String method,
    required Uri url,
    Map<String, String> headers,
    Map<String, String>? fields,
    Map<String, XFile>? files,
  });

  Future<HttpResponse> getResponseFromStream(StreamedResponse response);
}
