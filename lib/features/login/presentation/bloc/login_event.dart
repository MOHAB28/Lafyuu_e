part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserWantToLogin extends LoginEvent {
  final String email;
  final String password;
  UserWantToLogin({
    required this.email,
    required this.password,
  });
}
