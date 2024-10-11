import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toku_flutter_common/core.dart';

class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key});
  {{#if_family_bloc}}
  // TODO: inject {{name.pascalCase()}}Bloc
  //
  // Example:
  // static Widget provideRoute(GetIt getIt) {
  //  return BlocFamilyProvider{{bloc_children_count}}<{{bloc_family_provider_type_params}}>(
  //    family: getIt<BlocFamily<{{name.pascalCase()}}Bloc>>(),
  //    child: const {{name.pascalCase()}}View(),
  //  );
  // }
  //
  // Note: **provideRoute** is just an example, it may have different implementations
  // depending on navigation library used.
  {{/if_family_bloc}}
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{name.pascalCase()}}Bloc, {{name.pascalCase()}}State>(
      builder: (context, state) {
        // TODO: build view according to state
        return Container();
      },
    );
  }
}
