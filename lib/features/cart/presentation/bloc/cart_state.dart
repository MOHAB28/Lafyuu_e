part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();

  @override
  List<Object> get props => [];
}

class AddOrRemoveCartLoading extends CartState {
  const AddOrRemoveCartLoading();

  @override
  List<Object> get props => [];
}

class AddOrRemoveCartLoaded extends CartState {
  const AddOrRemoveCartLoaded();

  @override
  List<Object> get props => [];
}

class AddOrRemoveCartFailure extends CartState {
  const AddOrRemoveCartFailure();

  @override
  List<Object> get props => [];
}

class UpdateCartLoading extends CartState {}

class UpdateCartLoaded extends CartState {
  final StatusEntity statusEntity;
  const UpdateCartLoaded(this.statusEntity);
}

class UpdateCartFailure extends CartState {}

class GetCartsLoading extends CartState {
  const GetCartsLoading();

  @override
  List<Object> get props => [];
}

class GetCartsLoaded extends CartState {
  final CartEntity cartEntity;
  const GetCartsLoaded(this.cartEntity);

  @override
  List<Object> get props => [cartEntity];
}

class GetCartsFailure extends CartState {
  final PrimaryServerException exception;
  const GetCartsFailure(this.exception);

  @override
  List<Object> get props => [exception];
}
