import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/favourite_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/add_or_remove_fav_usecase.dart';
import '../../domain/usecases/get_favs_usecase.dart';
part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final GetAllFavouritesUsecase _getAllFavouritesUsecase;
  final AddOrRemoveFavUsecsae _removeFavUsecsae;
  static FavouriteBloc get(BuildContext context) => BlocProvider.of(context);
  FavouriteEntity? favouriteEntity;
  StatusEntity? statusEntity;
  FavouriteBloc(
    this._getAllFavouritesUsecase,
    this._removeFavUsecsae,
  ) : super(FavouriteInitial()) {
    on<GetAllFavoureitesEvent>((event, emit) async {
      emit(GetAllFavLoading());
      final successOrFailure = await _getAllFavouritesUsecase(NoParams());
      successOrFailure.fold(
        (failure) => emit(GetAllFavFailure()),
        (data) {
          favouriteEntity = data;
          emit(GetAllFavSuccess());
        },
      );
    });
    on<AddOrRemoveFavsEvent>((event, emit) async {
      emit(AddOrRemoveFavLoading());
      final successOrFailure = await _removeFavUsecsae(event.id);
      successOrFailure.fold(
        (failure) => emit(AddOrRemoveFavFailure()),
        (data) {
          statusEntity = data;
          emit(AddOrRemoveFavSuccess());
        },
      );
    });
  }
}
