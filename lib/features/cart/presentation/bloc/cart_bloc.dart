import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/usecases/add_or_remove_cart.dart';
import '../../domain/usecases/get_carts_usecase.dart';
import '../../domain/usecases/updata_cart_usecase.dart';
import '../../domain/entities/cart_entity.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartsUsecase _getCartsUsecase;
  final UpdateCartUsecase _updateCartUsecase;
  final AddOrRemoveCartUsecase _addOrRemoveCartUsecase;
  static CartBloc get(BuildContext context) => BlocProvider.of(context);
  StatusEntity? addStatus;
  StatusEntity? updateStatus;
  CartEntity? cartEntity;

  CartBloc(
    this._addOrRemoveCartUsecase,
    this._getCartsUsecase,
    this._updateCartUsecase,
  ) : super(CartInitial()) {
    on<AddOrRemoveCartEvent>((event, emit) async {
      emit(AddOrRemoveCartLoading());
      final successOrFailure = await _addOrRemoveCartUsecase(event.id);
      successOrFailure.fold(
        (failure) => emit(AddOrRemoveCartFailure()),
        (data) {
          addStatus = data;
          emit(AddOrRemoveCartLoaded(data));
        },
      );
    });
    on<GetCartsDataEvent>((event, emit) async {
      emit(GetCartsLoading());
      final successOrFailure = await _getCartsUsecase(NoParams());
      successOrFailure.fold(
        (failure) => emit(GetCartsFailure()),
        (data) {
          cartEntity = data;
          emit(GetCartsLoaded(data));
        },
      );
    });
    on<UpdateCartEvent>((event, emit) async {
      emit(UpdateCartLoading());
      final successOrFailure = await _updateCartUsecase(event.id);
      successOrFailure.fold(
        (failure) => emit(UpdateCartFailure()),
        (data) {
          updateStatus = data;
          emit(UpdateCartLoaded(data));
        },
      );
    });
  }
}
