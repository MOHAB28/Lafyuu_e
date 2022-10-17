part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddOrRemoveCartEvent extends CartEvent {
  final ProductsEntity  item;
  const AddOrRemoveCartEvent(this.item);
  @override
  List<Object> get props => [item];
}

class UpdateCartEvent extends CartEvent {
  final int id;
  final int quantity;
  const UpdateCartEvent({
    required this.id,
    required this.quantity,
  });
}

class GetCartsDataEvent extends CartEvent {}
