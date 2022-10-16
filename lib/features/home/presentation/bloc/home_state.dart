part of 'home_bloc.dart';

enum RequestState { loading, success, error }

class HomeState extends Equatable {
  const HomeState({
    this.homeEntity,
    this.status = RequestState.loading,
    this.error = '',
    this.message = '',
  });

  final HomeEntity? homeEntity;
  final RequestState status;
  final String error;
  final String message;

  HomeState copyWith({
    final HomeEntity? homeEntity,
    final RequestState? status,
    final String? error,
    final String? message,
  }) {
    return HomeState(
      error: error ?? this.error,
      message: message ?? this.message,
      status: status ?? this.status,
      homeEntity: homeEntity ?? this.homeEntity,
    );
  }

  @override
  List<Object?> get props => [
        homeEntity,
        status,
        error,
        message,
      ];
}