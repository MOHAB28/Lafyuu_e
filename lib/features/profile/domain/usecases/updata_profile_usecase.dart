import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../register/domain/repositories/register_repo.dart';
import '../../../register/domain/usecases/register_usecase.dart';
import '../repositories/profile_repo.dart';

class UpdataProfileUsecase
    extends BaseUseCase<RegisterUsecaseInput, AuthEntity> {
  final ProfileRepo _repo;
  UpdataProfileUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, AuthEntity>> call(RegisterUsecaseInput input) async {
    return await _repo.updataProfile(
      RegisterInput(
       email: input.email, 
       name: input.name, 
       phone: input.phone, 
      ),
    );
  }
}
