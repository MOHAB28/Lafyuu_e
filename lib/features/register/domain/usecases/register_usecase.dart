import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../repositories/register_repo.dart';

class RegisterUsecase extends BaseUseCase<RegisterUsecaseInput, AuthEntity> {
  final RegisterRepo _repo;
  RegisterUsecase(this._repo);
  @override
  Future<Either<PrimaryServerException, AuthEntity>> call(
      RegisterUsecaseInput input) async {
    return await _repo.register(
      RegisterInput(
        email: input.email,
        name: input.name,
        password: input.password,
        phone: input.phone,
      ),
    );
  }
}

class RegisterUsecaseInput {
  final String name;
  final String email;
  final String phone;
  final String? password;

  const RegisterUsecaseInput({
    required this.email,
    required this.name,
    this.password,
    required this.phone,
  });
}
