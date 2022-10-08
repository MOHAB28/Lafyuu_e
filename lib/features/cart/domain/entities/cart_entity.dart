import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/home_entity.dart';

class CartEntity extends Equatable {
  final bool status;
  final String message;
  final CartDataEntity cartData;
  const CartEntity({
    required this.cartData,
    required this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [
        cartData,
        message,
        status,
      ];
}

class CartDataEntity extends Equatable {
  final List<CartItemDataEntity> cartItemData;
  final dynamic subTotal;
  final dynamic total;
  const CartDataEntity({
    required this.cartItemData,
    required this.subTotal,
    required this.total,
  });

  @override
  List<Object?> get props => [
        cartItemData,
        subTotal,
        total,
      ];
}

class CartItemDataEntity extends Equatable {
  final int id;
  final int quantity;
  final ProductsEntity products;
  const CartItemDataEntity({
    required this.id,
    required this.products,
    required this.quantity,
  });

  @override
  List<Object?> get props => [
        id,
        products,
        quantity,
      ];
}
