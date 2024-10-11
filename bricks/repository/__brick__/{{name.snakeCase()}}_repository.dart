import 'package:toku_flutter_common/core.dart';

// TODO: Don't forget to generate the files using build_runner
@lazySingleton
abstract class {{name.pascalCase()}}Repository {
  @factoryMethod
  factory {{name.pascalCase()}}Repository(
    // TODO: Add dependencies here, example:
    /// {{name.pascalCase()}}RemoteSource {{name.camelCase()}}RemoteSource,
  ) = _{{name.pascalCase()}}RepositoryImpl;

  // TODO: Add initialization here, if needed, example:
  /// Future<void> initialize();
  
  // TODO: Add getters here, if needed, example:
  /// Read-only list of all fetched {{name.pascalCase()}}s
  /// List<{{name.pascalCase()}}> get {{name.camelCase()}}s;
}

class _{{name.pascalCase()}}RepositoryImpl implements {{name.pascalCase()}}Repository {
  _{{name.pascalCase()}}RepositoryImpl(
    // TODO: Add dependencies here, example:
    /// this._{{name.camelCase()}}RemoteSource,
  );

  /// final {{name.pascalCase()}}RemoteSource _{{name.camelCase()}}RemoteSource;
  
  // TODO: Implement the methods/getters here, example:
  /// @override
  /// Future<void> initialize() async {
  ///   ...
  /// }
  ///
  /// List<{{name.pascalCase()}}> _{{name.camelCase()}}s = <{{name.pascalCase()}}>[];
  /// @override
  /// List<{{name.pascalCase()}}> get {{name.camelCase()}}s => _{{name.camelCase()}}s;
}
