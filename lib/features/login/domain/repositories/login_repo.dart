import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../entities/login_entity.dart';

abstract class LoginRepo {
  Future<Either<PrimaryServerException, AuthEntity>> login(LoginInput input);
}

class LoginInput {
  final String email;
  final String password;

  const LoginInput({
    required this.email,
    required this.password,
  });
}
