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
  Map<int?, int?> quantity = {};
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
        (failure) {
          debugPrint(failure.message);
          emit(AddOrRemoveCartFailure());
        },
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
        (failure) {
          debugPrint('Mohab ${failure.error}');
          emit(GetCartsFailure());
        },
        (data) {
          for (var element in data.cartData.cartItemData) {
            quantity.addAll({
              element.id: element.quantity,
            });
          }
          cartEntity = data;
          emit(GetCartsLoaded(data));
        },
      );
    });
    on<IncreaseQuantityEvent>((event, emit) async {
      int q = quantity[event.id]!;
      q++;
      quantity[event.id] = q;
      emit(IncreaseQuantityState());
    });
    on<DecreaseQuantityEvent>((event, emit) async {
      int q = quantity[event.id]!;
      q--;
      if (q < 0) {
        q = 0;
        quantity[event.id] = q;
        emit(DecreaseQuantityState());
      } else {
        quantity[event.id] = q;
        emit(DecreaseQuantityState());
      }
    });
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
          updateStatus = data;
          emit(UpdateCartLoaded(data));
        },
      );
    });
  }
}
