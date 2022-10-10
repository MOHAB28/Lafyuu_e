import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/usecases/home_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeDataUsecase _usecase;
  static HomeBloc get(context) => BlocProvider.of(context);
  HomeEntity? homeData;
  Map<int?, bool?> favorties = {};
  Map<int?, bool?> carts = {};

  HomeBloc(this._usecase) : super(HomeInitial()) {
    on<GetHomeDataEvent>((event, emit) async {
      emit(HomeLoading());
      final successOrFailure = await _usecase(NoParams());
      successOrFailure.fold(
        (failure) => emit(HomeFailure(failure)),
        (data) {
          homeData = data;
          for (var element in data.homeData.products) {
            favorties.addAll({
              element.id: element.inFav,
            });
          }
          for (var element in data.homeData.products) {
            carts.addAll({
              element.id: element.inCart,
            });
          }
          emit(HomeLoaded());
        },
      );
    });
    on<ChangeFavEvent>((event, emit) {
      if (favorties[event.id] == false) {
        favorties[event.id] = true;
        emit(ChangeFavoritesState());
      } else if (favorties[event.id] == true) {
        favorties[event.id] = false;
        emit(ChangeFavoritesState());
      }
    });
    on<ChangeCartEvent>((event, emit) {
      if (carts[event.id] == false) {
        carts[event.id] = true;
        emit(ChangeCartsState());
      } else if (carts[event.id] == true) {
        carts[event.id] = false;
        emit(ChangeCartsState());
      }
    });
  }
}
