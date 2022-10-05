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
  HomeEntity? homeData;

  HomeBloc(this._usecase) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      final successOrFailure = await _usecase(NoParams());
      successOrFailure.fold(
        (failure) => emit(HomeFailure()),
        (data) {
          homeData = data;
          emit(HomeLoading());
        },
      );
    });
  }
}
