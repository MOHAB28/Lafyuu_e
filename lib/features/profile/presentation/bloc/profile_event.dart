part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetProfileDataEvent extends ProfileEvent {}

class UpdataProfileDataEvent extends ProfileEvent {
  final String name;
  final String email;
  final String phone;
  final String? password;

  const UpdataProfileDataEvent({
    required this.email,
    required this.name,
    this.password,
    required this.phone,
  });
}
