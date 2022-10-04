part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();  

  @override
  List<Object> get props => [];
}
class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final AuthEntity data;
  const LoginSuccess({required this.data});
}

class LoginFailure extends LoginState {}
