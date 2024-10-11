import 'package:shared_preferences/shared_preferences.dart';

import 'package:toku_flutter_common/core.dart';

// TODO: don't forget to generate the files using build_runner
@lazySingleton
abstract class {{name.pascalCase()}}LocalSource {
  @factoryMethod
  const factory {{name.pascalCase()}}LocalSource(
    SharedPreferences sharedPreferences,
  ) = _{{name.pascalCase()}}LocalSourceImpl;

  // TODO: Add getters and setters here, example:
  /// /// Gets the name
  /// ///
  /// /// Empty string will be returned as null
  /// Result<String?> getName();
  ///
  /// /// Sets the name
  /// ///
  /// /// Set to null or empty string to remove the name
  /// Future<Result<bool>> setName(String? name);
}

class _{{name.pascalCase()}}LocalSourceImpl implements {{name.pascalCase()}}LocalSource {
  const _{{name.pascalCase()}}LocalSourceImpl(
    this._sharedPreferences,
  );

  final SharedPreferences _sharedPreferences;

  // TODO: Implement the getters and setters here, example:
  /// @override
  /// Result<String?> getName() {
  ///   try {
  ///     final name = _sharedPreferences.getString(kNameKey);
  ///     return Result.success(name);
  ///   } on Exception catch (e) {
  ///     return Result.error(e);
  ///   }
  /// }
  ///
  /// @override
  /// Future<Result<bool>> setName(String? name) async {
  ///   try {
  ///     final isSuccess = name == null || name.isEmpty
  ///        ? await _sharedPreferences.remove(kNameKey)
  ///        : await _sharedPreferences.setString(kNameKey, name);
  ///     return Result.success(isSuccess);
  ///   } on Exception catch (e) {
  ///     return Result.error(e);
  ///   }
  /// }
}
