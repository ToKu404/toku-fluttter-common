import 'package:toku_flutter_common/core.dart';

{{#if_with_use_case_input_class}}
class {{name.pascalCase()}}Input {
  const {{name.pascalCase()}}Input(/*{
    // TODO: Add properties here, example:
    // this.name,
  }*/);
}
{{/if_with_use_case_input_class}}

@lazySingleton
class {{name.pascalCase()}}UseCase implements {{{use_case_type}}} {
  const {{name.pascalCase()}}UseCase();

  @override
  {{{use_case_output_type}}} call({{{use_case_input_type}}}) {
    // TODO: implement {{name.pascalCase()}}UseCase.call
  }
}
