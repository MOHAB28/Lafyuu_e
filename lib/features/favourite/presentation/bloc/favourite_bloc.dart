import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lafyuu/core/error/exception.dart';
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
  Map<int, FavouriteProductEntity> urFavs = {};
  FavouriteBloc(
    this._getAllFavouritesUsecase,
    this._removeFavUsecsae,
  ) : super(const FavouriteInitial()) {
    on<GetAllFavoureitesEvent>(_getAllFavourites);
    on<AddOrRemoveFavsEvent>(_addOrRemoveItem);
  }

  FutureOr<void> _getAllFavourites(
      GetAllFavoureitesEvent event, Emitter<FavouriteState> emit) async {
    emit(const GetAllFavLoading());
    final successOrFailure = await _getAllFavouritesUsecase(NoParams());
    successOrFailure.fold(
      (failure) {
        debugPrint(failure.message);
        emit(GetAllFavFailure(failure));
      },
      (data) {
        for (var product in data.favProductsEntity.products) {
          urFavs.addAll({product.id: product});
        }
        emit(GetAllFavSuccess([...data.favProductsEntity.products]));
      },
    );
  }

  FutureOr<void> _addOrRemoveItem(
      AddOrRemoveFavsEvent event, Emitter<FavouriteState> emit) async {
    emit(const AddOrRemoveFavLoading());
    final successOrFailure = await _removeFavUsecsae(event.item.id);
    successOrFailure.fold(
      (failure) => emit(AddOrRemoveFavFailure(failure.message)),
      (data) {
        urFavs.containsKey(event.item.id)
            ? urFavs.remove(event.item.id)
            : urFavs.addAll({event.item.id: event.item});
        emit(AddOrRemoveFavSuccess(data.message));
      },
    );
  }
}
