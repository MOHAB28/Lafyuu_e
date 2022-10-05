import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/features/register/domain/usecases/register_usecase.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';
import '../../domain/usecases/updata_profile_usecase.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdataProfileUsecase _updataProfileUsecase;
  final GetProfileDataUsecase _getProfileDataUsecase;
  static ProfileBloc get(BuildContext context) => BlocProvider.of(context);
  AuthEntity? authData;
  ProfileBloc(this._getProfileDataUsecase, this._updataProfileUsecase)
      : super(ProfileInitial()) {
    on<GetProfileDataEvent>((event, emit) async {
      emit(GetProfileDataLoading());
      final successOrFailure = await _getProfileDataUsecase(NoParams());
      successOrFailure.fold(
        (failure) => emit(GetProfileDataFailure()),
        (data) {
          authData = data;
          emit(GetProfileDataSuccess());
        },
      );
    });
    on<UpdataProfileDataEvent>((event, emit) async {
      emit(UpdataProfileLoading());
      final successOrFailure = await _updataProfileUsecase(
        RegisterUsecaseInput(
          email: event.email,
          name: event.name,
          phone: event.phone,
        ),
      );

      successOrFailure.fold(
        (failure) => emit(UpdataProfileFailure()),
        (data) {
          authData = data;
          emit(UpdataProfileSuccess(data));
        },
      );
    });
  }
}
