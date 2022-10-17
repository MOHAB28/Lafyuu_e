import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../domain/usecases/add_or_remove_cart.dart';
import '../../domain/usecases/get_carts_usecase.dart';
import '../../domain/usecases/updata_cart_usecase.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartsUsecase _getCartsUsecase;
  final UpdateCartUsecase _updateCartUsecase;
  final AddOrRemoveCartUsecase _addOrRemoveCartUsecase;
  static CartBloc get(BuildContext context) => BlocProvider.of(context);
  Map<int, CartItemDataEntity> urCart = {};
  dynamic total = 0;
  CartBloc(
    this._addOrRemoveCartUsecase,
    this._getCartsUsecase,
    this._updateCartUsecase,
  ) : super(const CartInitial()) {
    on<AddOrRemoveCartEvent>(_addOrRemoveCart);
    on<GetCartsDataEvent>(_onGetCarts);
    on<UpdateCartEvent>((event, emit) async {
      emit(UpdateCartLoading());
      final successOrFailure = await _updateCartUsecase(
        UpdateCartUsecaseInput(
          id: event.id,
          quantity: event.quantity,
        ),
      );
      successOrFailure.fold(
        (failure) => emit(UpdateCartFailure()),
        (data) {
          emit(UpdateCartLoaded(data));
        },
      );
    });
  }

  FutureOr<void> _onGetCarts(
    GetCartsDataEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(const GetCartsLoading());
    final successOrFailure = await _getCartsUsecase(NoParams());
    successOrFailure.fold(
      (failure) {
        debugPrint('Mohab ${failure.error}');
        emit(GetCartsFailure(failure));
      },
      (data) {
        for (var cart in data.cartData.cartItemData) {
          urCart.addAll({cart.products.id: cart});
        }
        emit(GetCartsLoaded(data));
      },
    );
  }

  FutureOr<void> _addOrRemoveCart(
    AddOrRemoveCartEvent event,
    Emitter<CartState> emit,
  ) async {
    emit(const AddOrRemoveCartLoading());
    final successOrFailure = await _addOrRemoveCartUsecase(event.item.id);

    successOrFailure.fold(
      (failure) {
        debugPrint(failure.message);
        emit(const AddOrRemoveCartFailure());
      },
      (data) {
        urCart.containsKey(event.item.id)
            ? urCart.remove(event.item.id)
            : urCart.addAll(
                {
                  event.item.id: CartItemDataEntity(
                    id: data.id,
                    quantity: data.quantity,
                    products: data.products,
                  ),
                },
              );
        emit(const AddOrRemoveCartLoaded());
      },
    );
  }
}
