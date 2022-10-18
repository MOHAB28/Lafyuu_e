part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddOrRemoveCartEvent extends CartEvent {
  final ProductsEntity item;
  const AddOrRemoveCartEvent(this.item);
  @override
  List<Object> get props => [item];
}

class GetCartsDataEvent extends CartEvent {
  const GetCartsDataEvent();

  @override
  List<Object> get props => [];
}

class IncreaseQuantityItemEvent extends CartEvent {
  const IncreaseQuantityItemEvent(this.cartItem);
  final CartItemDataEntity cartItem;
  @override
  List<Object> get props => [cartItem];
}

class DecreaseQuantityItemEvent extends CartEvent {
  const DecreaseQuantityItemEvent(this.cartItem);
  final CartItemDataEntity cartItem;
  @override
  List<Object> get props => [cartItem];
}
