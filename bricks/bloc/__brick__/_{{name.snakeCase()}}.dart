{{#if_family_bloc}}
import 'package:toku_flutter_common/core.dart';
import '{{name.snakeCase()}}_bloc.dart';
{{/if_family_bloc}}
export '{{name.snakeCase()}}_bloc.dart';
{{#if_family_bloc}}
@module
abstract class {{name.pascalCase()}}BlocDependencyProvider {
  BlocFamily<{{name.pascalCase()}}Bloc> provide{{name.pascalCase()}}BlocFamily(
    {{name.pascalCase()}}Bloc {{name.camelCase()}}Bloc,
    {{#for_each_bloc_children}}
    {{name.pascalCase()}}Bloc {{name.camelCase()}}Bloc,
    {{/for_each_bloc_children}}
  ) {
    return BlocFamily<{{name.pascalCase()}}Bloc>(
      parent: {{name.camelCase()}}Bloc
        ..initialize(
          {{#for_each_bloc_children}}
          {{name.camelCase()}}Bloc,
          {{/for_each_bloc_children}}
        ),
      children: {
        {{#for_each_bloc_children}}
        {{name.camelCase()}}Bloc,
        {{/for_each_bloc_children}}
      },
    );
  }
}
{{/if_family_bloc}}