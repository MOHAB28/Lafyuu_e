import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../register/domain/repositories/register_repo.dart';

abstract class ProfileRepo {
  Future<Either<PrimaryServerException,AuthEntity>> getProfileData();
  Future<Either<PrimaryServerException,AuthEntity>> updataProfile(RegisterInput input);
}
