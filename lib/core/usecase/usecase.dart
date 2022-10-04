import 'package:dartz/dartz.dart';
import '../error/exception.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<PrimaryServerException, Out>> call(In input);
}

class NoParams {}