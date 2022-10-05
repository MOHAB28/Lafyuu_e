import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/profile_repo.dart';

class GetProfileDataUsecase extends BaseUseCase<NoParams, AuthEntity> {
  final ProfileRepo _repo;
  GetProfileDataUsecase(this._repo);
  @override
  Future<Either<PrimaryServerException, AuthEntity>> call(NoParams input) async {
   return await _repo.getProfileData();
  }
}
