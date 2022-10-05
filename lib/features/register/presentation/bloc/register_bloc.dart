import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/exception.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../domain/usecases/register_usecase.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _usecase;
  RegisterBloc(this._usecase) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<UserWantToRegister>((event, emit) async {
      emit(RegisterLoading());
      final successOrFailure = await _usecase(
        RegisterUsecaseInput(
          email: event.email,
          name: event.name,
          phone: event.phone,
          password: event.password,
        ),
      );

      successOrFailure.fold(
        (failure) => emit(RegisterFailure(exception: failure)),
        (data) => emit(RegisterSuccess(data: data)),
      );
    });
  }
}
