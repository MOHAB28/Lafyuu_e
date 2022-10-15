import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeDataUsecase _usecase;
  static HomeBloc get(context) => BlocProvider.of(context);

  HomeBloc(this._usecase) : super(const HomeState()) {
    on<GetHomeDataEvent>(_onGetHomeData);
  }

  FutureOr<void> _onGetHomeData(
      GetHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(state);
    final successOrFailure = await _usecase(NoParams());
    successOrFailure.fold(
      (failure) => emit(
        state.copyWith(
          status: RequestState.error,
          error: failure.error,
          message: failure.message,
        ),
      ),
      (data) => emit(
        state.copyWith(
          homeEntity: data,
          status: RequestState.success,
        ),
      ),
    );
  }
}
