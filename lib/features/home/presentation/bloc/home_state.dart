part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeFailure extends HomeState {
  final PrimaryServerException exception;
  const HomeFailure(this.exception);
}

class ChangeFavoritesState extends HomeState {}

class ChangeCartsState extends HomeState {}
