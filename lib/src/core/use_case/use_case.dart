import 'package:kartjis_mobile_common/src/core/models/result.dart';

abstract class UseCase<I, O> {
  O call(I input);
}

abstract class FutureUseCase<I, O> extends UseCase<I, Future<O>> {}

abstract class ResultUseCase<I, O> extends UseCase<I, Result<O>> {}

abstract class FutureResultUseCase<I, O>
    extends UseCase<I, Future<Result<O>>> {}

abstract class NoInputUseCase<O> {
  O call();
}

abstract class NoInputResultUseCase<O> extends NoInputUseCase<Result<O>> {}

abstract class NoInputFutureUseCase<O> extends NoInputUseCase<Future<O>> {}

abstract class NoInputFutureResultUseCase<O>
    extends NoInputUseCase<Future<Result<O>>> {}
