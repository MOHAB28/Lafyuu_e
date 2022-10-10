part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class AddOrRemoveCartLoading extends CartState {}

class AddOrRemoveCartLoaded extends CartState {
  final StatusEntity statusEntity;
  const AddOrRemoveCartLoaded(this.statusEntity);
}

class AddOrRemoveCartFailure extends CartState {}

class UpdateCartLoading extends CartState {}

class UpdateCartLoaded extends CartState {
  final StatusEntity statusEntity;
  const UpdateCartLoaded(this.statusEntity);
}

class UpdateCartFailure extends CartState {}

class GetCartsLoading extends CartState {}

class GetCartsLoaded extends CartState {
  final CartEntity cartEntity;
  const GetCartsLoaded(this.cartEntity);
}

class GetCartsFailure extends CartState {
  final PrimaryServerException exception;
  const GetCartsFailure(this.exception);
}

class InitIncreaseQuantityState extends CartState {}

class IncreaseQuantityState extends CartState {}

class InitDecreaseQuantityState extends CartState {}

class DecreaseQuantityState extends CartState {}
