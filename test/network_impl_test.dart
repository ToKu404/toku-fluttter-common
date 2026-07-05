import 'dart:io';
import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:toku_flutter_common/src/network/http/_http.dart';
import 'package:toku_flutter_common/src/network/network/network_impl.dart';

void main() {
  test('createMultipartRequest sets filename and content type from XFile.path',
      () async {
    final file = File('${Directory.systemTemp.path}/test_image.jpg');
    await file.writeAsBytes(<int>[0xFF, 0xD8, 0xFF]);
    final xFile = XFile(file.path);

    const network = NetworkImpl();
    final request = await network.createMultipartRequest(
      method: 'PUT',
      url: Uri.parse('https://example.com'),
      files: {'file': xFile},
    );

    expect(request.files, isNotEmpty);
    expect(request.files.first.filename, 'test_image.jpg');
    expect(request.files.first.contentType.toString(), 'image/jpeg');

    await file.delete();
  });

  test('createMultipartRequest infers filename and content type for byte XFile',
      () async {
    final xFile = XFile.fromData(
      Uint8List.fromList(<int>[0xFF, 0xD8, 0xFF]),
      mimeType: 'image/jpeg',
    );

    const network = NetworkImpl();
    final request = await network.createMultipartRequest(
      method: 'PUT',
      url: Uri.parse('https://example.com'),
      files: {'file': xFile},
    );

    expect(request.files, isNotEmpty);
    expect(request.files.first.filename, 'file.jpg');
    expect(request.files.first.contentType.toString(), 'image/jpeg');
  });

  test('MultipartRequest.copy preserves file metadata', () async {
    const network = NetworkImpl();
    final request = await network.createMultipartRequest(
      method: 'PUT',
      url: Uri.parse('https://example.com'),
      files: {
        'image': XFile.fromData(
          Uint8List.fromList(<int>[0x89, 0x50, 0x4E, 0x47]),
          mimeType: 'image/png',
        ),
      },
    );

    final copy = request.copy();

    expect(copy.files, isNotEmpty);
    expect(copy.files.first.filename, 'image.png');
    expect(copy.files.first.contentType.toString(), 'image/png');
  });
}
