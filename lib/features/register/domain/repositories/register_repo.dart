import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../login/domain/entities/login_entity.dart';

abstract class RegisterRepo {
  Future<Either<PrimaryServerException, AuthEntity>> register(RegisterInput input);
}

class RegisterInput {
  final String name;
  final String email;
  final String phone;
  final String? password;

  const RegisterInput({
    required this.email,
    required this.name,
    this.password,
    required this.phone,
  });
}
