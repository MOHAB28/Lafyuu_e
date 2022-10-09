import '../../../home/data/models/home_model.dart';
import '../../domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  final CartDataModel? cartDataM;
  CartModel({
    bool? status,
    String? message,
    this.cartDataM,
  }) : super(
          cartData: cartDataM!,
          message: message!,
          status: status!,
        );

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      status: json['status'],
      message: json['message'] ?? '',
      cartDataM:
          json['data'] != null ? CartDataModel.fromJson(json['data']) : null,
    );
  }
}

class CartDataModel extends CartDataEntity {
  final List<CartItemDataModel>? cartItemDataM;
  CartDataModel({
    dynamic subTotal,
    dynamic total,
    this.cartItemDataM,
  }) : super(
          cartItemData: cartItemDataM!,
          subTotal: subTotal!,
          total: total!,
        );

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    List<CartItemDataModel> carts = [];
    if (json['cart_items'] != null) {
      for (var cart in json['cart_items']) {
        carts.add(CartItemDataModel.fromJson(cart));
      }
    }
    return CartDataModel(
      subTotal: json['sub_total'],
      cartItemDataM: carts,
      total: json['total'],
    );
  }
}

class CartItemDataModel extends CartItemDataEntity {
  final ProductsModel? product;
  CartItemDataModel({
    int? id,
    int? quantity,
    this.product,
  }) : super(
          id: id!,
          quantity: quantity!,
          products: product!,
        );
  factory CartItemDataModel.fromJson(Map<String, dynamic> json) {
    return CartItemDataModel(
      id: json['id'],
      quantity: json['quantity'],
      product: json['product'] != null
          ? ProductsModel.fromJson(json['product'])
          : null,
    );
  }
}
