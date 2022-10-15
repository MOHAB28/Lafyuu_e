part of 'product_details_bloc.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
  @override
  List<Object?> get props => [];
}

class ProductDetailsStateInitial extends ProductDetailsState {
  const ProductDetailsStateInitial();
  @override
  List<Object?> get props => [];
}

class ProductDetailsStateLoading extends ProductDetailsState {
  const ProductDetailsStateLoading();
  @override
  List<Object?> get props => [];
}

class ProductDetailsStateSuccess extends ProductDetailsState {
  final ProductsEntity product;
  const ProductDetailsStateSuccess(this.product);
  @override
  List<Object?> get props => [product];
}

class ProductDetailsStateFailure extends ProductDetailsState {
  final PrimaryServerException exception;
  const ProductDetailsStateFailure(this.exception);
  @override
  List<Object?> get props => [exception];
}
