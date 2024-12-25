import 'package:toku_flutter_common/core.dart';

@internal
@module
abstract class CoreDependencyProvider {
  @debouncer250ms
  Debouncer get provideDebouncer250ms => Debouncer(250);

  @debouncer500ms
  Debouncer get provideDebouncer500ms => Debouncer(500);

  @optionalStringValidator
  StringValidator get provideOptionalStringValidator => StringValidator.create(
        validators: <StringValidatorCallback>[],
        isOptional: true,
      );
}
