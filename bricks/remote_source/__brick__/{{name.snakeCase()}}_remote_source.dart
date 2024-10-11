import 'package:toku_flutter_common/core.dart';

// TODO: don't forget to generate the files using build_runner
@lazySingleton
abstract class {{name.pascalCase()}}RemoteSource {
  @factoryMethod
  const factory {{name.pascalCase()}}RemoteSource(
    HttpClient client,
  ) = _{{name.pascalCase()}}RemoteSourceImpl;

  // TODO: Add methods here, example:
  /// Future<Result<String>> getName();
}

class _{{name.pascalCase()}}RemoteSourceImpl implements {{name.pascalCase()}}RemoteSource {
  const _{{name.pascalCase()}}RemoteSourceImpl(
    this._client,
  );

  final HttpClient _client;

  // TODO: Implement the methods here, example:
  /// @override
  /// Future<Result<String>> getName() {
  ///   return _client.send(...);
  /// }

}
