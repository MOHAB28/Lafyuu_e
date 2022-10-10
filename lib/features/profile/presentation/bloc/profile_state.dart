part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetProfileDataLoading extends ProfileState {}

class GetProfileDataSuccess extends ProfileState {}

class GetProfileDataFailure extends ProfileState {
  final PrimaryServerException exception;
  const GetProfileDataFailure(this.exception);
}

class UpdataProfileLoading extends ProfileState {}

class UpdataProfileSuccess extends ProfileState {
  final AuthEntity authEntity;
  const UpdataProfileSuccess(this.authEntity);
}

class UpdataProfileFailure extends ProfileState {}
