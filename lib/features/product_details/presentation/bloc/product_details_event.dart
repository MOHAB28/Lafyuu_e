part of 'product_details_bloc.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetProductsDetailsEvent extends ProductDetailsEvent {
  final int id;
  const GetProductsDetailsEvent(this.id);
  @override
  List<Object> get props => [id];
}
