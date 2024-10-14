import 'package:finwell/core/errors/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCases<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params parameters);
}

class NoParamsType {}
