import 'package:mason/mason.dart';

void run(HookContext context) {
  String? inputType = context.vars['input_type'] as String?;
  final outputType = context.vars['output_type'] as String?;
  final resultType = context.vars['result_type'] as String?;

  final bool ifWithUseCaseInputClass = inputType?.toLowerCase().endsWith('input') == true;
  if (ifWithUseCaseInputClass) inputType = inputType?.pascalCase;

  final String useCaseType;
  final String useCaseInputType;
  final String useCaseOutputType;

  switch (resultType) {
    case 'UseCase':
      useCaseType = 'UseCase<$inputType, $outputType>';
      useCaseInputType = '$inputType input';
      useCaseOutputType = '$outputType';
      break;
    case 'ResultUseCase':
      useCaseType = 'ResultUseCase<$inputType, $outputType>';
      useCaseInputType = '$inputType input';
      useCaseOutputType = 'Result<$outputType>';
      break;
    case 'FutureResultUseCase':
      useCaseType = 'FutureResultUseCase<$inputType, $outputType>';
      useCaseInputType = '$inputType input';
      useCaseOutputType = 'Future<Result<$outputType>>';
      break;
    case 'NoInputUseCase':
      useCaseType = 'NoInputUseCase<$outputType>';
      useCaseInputType = '';
      useCaseOutputType = '$outputType';
      break;
    case 'NoInputResultUseCase':
      useCaseType = 'NoInputResultUseCase<$outputType>';
      useCaseInputType = '';
      useCaseOutputType = 'Result<$outputType>';
      break;
    case 'NoInputFutureResultUseCase':
      useCaseType = 'NoInputFutureResultUseCase<$outputType>';
      useCaseInputType = '';
      useCaseOutputType = 'Future<Result<$outputType>>';
      break;
    default:
      throw ArgumentError.value(
        resultType,
        'result_type',
        'Invalid result type',
      );
  }

  context.vars = {
    ...context.vars,
    'if_with_use_case_input_class': ifWithUseCaseInputClass,
    'use_case_type': useCaseType,
    'use_case_input_type': useCaseInputType,
    'use_case_output_type': useCaseOutputType,
  };
}
