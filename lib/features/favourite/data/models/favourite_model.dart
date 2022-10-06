import '../../domain/entities/favourite_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    String? message,
    bool? status,
  }) : super(
          message: message!,
          status: status!,
        );
  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      message: json['message'] ?? '',
      status: json['status'],
    );
  }
}

class FavouriteProductModel extends FavouriteProductEntity {
  FavouriteProductModel({
    int? id,
    String? image,
    String? name,
    String? description,
    dynamic price,
    dynamic oldPrice,
    int? discount,
  }) : super(
          id: id!,
          image: image!,
          name: name!,
          description: description!,
          price: price,
          oldPrice: oldPrice,
          discount: discount!,
        );

  factory FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavouriteProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'] ?? 0,
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

class FavProductsModel extends FavProductsEntity {
  FavProductsModel({
    List<FavouriteProductModel>? products,
  }) : super(products: products!);

  factory FavProductsModel.fromJson(Map<String, dynamic> json) {
    List<FavouriteProductModel>? fP = [];
    if (json['data'] != null) {
      for (var product in json['data']) {
        fP.add(FavouriteProductModel.fromJson(product['product']));
      }
    }
    return FavProductsModel(
      products: fP,
    );
  }
}

class FavouriteModel extends FavouriteEntity {
  FavouriteModel({
    StatusModel? status,
    FavProductsModel? favProductsModel,
  }) : super(
          status: status!,
          favProductsEntity: favProductsModel!,
        );

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      status: StatusModel.fromJson(json),
      favProductsModel:
          json['data'] != null ? FavProductsModel.fromJson(json['data']) : null,
    );
  }
}
