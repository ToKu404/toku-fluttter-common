import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:http_parser/http_parser.dart';
import 'package:test/test.dart';
import 'package:toku_flutter_common/src/network/network/network_impl.dart';

void main() {
  test('createMultipartRequest sets filename from XFile.path', () async {
    final tmpDir = Directory.systemTemp;
    final file = File('${tmpDir.path}/test_image.jpg');
    await file.writeAsBytes(<int>[0xFF, 0xD8, 0xFF]); // minimal JPEG header
    final xfile = XFile(file.path);

    final network = const NetworkImpl();
    final req = await network.createMultipartRequest(
      method: 'PUT',
      url: Uri.parse('https://example.com'),
      files: {'file': xfile},
    );

    expect(req.files, isNotEmpty);
    expect(req.files.first.filename, 'test_image.jpg');
    expect(req.files.first.contentType, MediaType('image', 'jpeg'));

    await file.delete();
  });

  test('createMultipartRequest infers filename and contentType for byte-only XFile', () async {
    final xfile = XFile.fromData(
      <int>[0xFF, 0xD8, 0xFF],
      mimeType: 'image/jpeg',
    );

    final network = const NetworkImpl();
    final req = await network.createMultipartRequest(
      method: 'PUT',
      url: Uri.parse('https://example.com'),
      files: {'file': xfile},
    );

    expect(req.files, isNotEmpty);
    expect(req.files.first.filename, 'file.jpg');
    expect(req.files.first.contentType, MediaType('image', 'jpeg'));
  });
}
