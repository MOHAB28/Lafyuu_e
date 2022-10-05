import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/usecases/login_usecase.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase _usecase;
  static LoginBloc get(BuildContext context) => BlocProvider.of(context);
  LoginBloc(
    this._usecase,
  ) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {});
    on<UserWantToLogin>((event, emit) async {
      emit(LoginLoading());
      final successOrFailure = await _usecase(
        LoginUsecaseInput(
          email: event.email,
          password: event.password,
        ),
      );

      successOrFailure.fold(
        (failure) => emit(LoginFailure(exception: failure)),
        (data) => emit(LoginSuccess(data: data)),
      );
    });
  }
}
