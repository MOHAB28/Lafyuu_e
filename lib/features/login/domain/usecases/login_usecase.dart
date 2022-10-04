import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repo.dart';

class LoginUsecase extends BaseUseCase<LoginUsecaseInput, AuthEntity> {
  final LoginRepo _repo;
  LoginUsecase(this._repo);
  @override
  Future<Either<PrimaryServerException, AuthEntity>> call(LoginUsecaseInput input) async {
    return await _repo.login(
      LoginInput(
        email: input.email,
        password: input.password,
      ),
    );
  }
}

class LoginUsecaseInput {
  final String email;
  final String password;

  const LoginUsecaseInput({
    required this.email,
    required this.password,
  });
}
