import 'package:mason/mason.dart';

enum _BlocType {
  relational,
  family,
  standalone,
}

void run(HookContext context) {
  final blocName = context.vars['name'] as String;
  final blocTypeString = context.vars['bloc_type'] as String?;
  final _BlocType blocType;
  final blocChildrenString = context.vars['bloc_children'] as String?;

  final List<String>? blocChildren;
  final List<Map<String, String>> forEachBlocChildren;

  switch (blocTypeString) {
    case 'Relational Bloc':
      blocType = _BlocType.relational;
      blocChildren = null;
      forEachBlocChildren = [];
      break;
    case 'Family Bloc':
      blocType = _BlocType.family;
      blocChildren = blocChildrenString!.split(',').map((name) => name.trim()).toList(growable: false);
      forEachBlocChildren = blocChildren.map((String name) => {'name': name}).toList(growable: false);
      break;
    case 'Standalone Bloc':
      blocType = _BlocType.standalone;
      blocChildren = null;
      forEachBlocChildren = [];
      break;
    default:
      throw ArgumentError.value(
        blocTypeString,
        'bloc_type',
        'Invalid Bloc type',
      );
  }

  context.vars = {
    ...context.vars,
    'if_relational_bloc': blocType == _BlocType.relational,
    'if_family_bloc': blocType == _BlocType.family,
    'if_standalone_bloc': blocType == _BlocType.standalone,
    if (blocType == _BlocType.family) ...{
      'bloc_children_count': forEachBlocChildren.length,
      'for_each_bloc_children': forEachBlocChildren,
      'bloc_family_provider_type_params': [
        blocName,
        ...blocChildren!,
      ].map((bloc) => '${bloc.pascalCase}Bloc').join(', '),
    }
  };
}
