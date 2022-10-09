part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddOrRemoveCartEvent extends CartEvent {
  final int id;
  const AddOrRemoveCartEvent(this.id);
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

class IncreaseQuantityEvent extends CartEvent {
  final int id;
  const IncreaseQuantityEvent(this.id);
}

class DecreaseQuantityEvent extends CartEvent {
  final int id;
  const DecreaseQuantityEvent(this.id);
}
