part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class UserWantToRegister extends RegisterEvent {
  final String name;
  final String email;
  final String phone;
  final String? password;

  const UserWantToRegister({
    required this.email,
    required this.name,
    this.password,
    required this.phone,
  });
}
