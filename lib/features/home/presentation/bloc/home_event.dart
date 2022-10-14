part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetHomeDataEvent extends HomeEvent {}

class ChangeFavEvent extends HomeEvent {
  final int id;
  const ChangeFavEvent(this.id);
  @override
  List<Object> get props => [id];
}

class ChangeCartEvent extends HomeEvent {
  final int id;
  const ChangeCartEvent(this.id);
  @override
  List<Object> get props => [id];
}
