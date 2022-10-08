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
  const UpdateCartEvent(this.id);
}

class GetCartsDataEvent extends CartEvent {}
