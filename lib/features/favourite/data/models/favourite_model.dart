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
    dynamic discount,
  }) : super(
          id: id!,
          image: image!,
          name: name!,
          description: description!,
          price: price,
          oldPrice: oldPrice,
          discount: discount,
        );

  factory FavouriteProductModel.fromJson(Map<String, dynamic> json) {
    return FavouriteProductModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
    );
  }
}

class FavouriteModel extends FavouriteEntity {
  FavouriteModel({
    StatusModel? status,
    List<FavouriteProductModel>? products,
  }) : super(products: products!, status: status!);

  factory FavouriteModel.fromJson(Map<String,dynamic> json) {
    List<FavouriteProductModel>? fP = [];
    if(json['data'] != null) {
      for(var product in json['data']) {
        fP.add(FavouriteProductModel.fromJson(product));
      }
    }
    return FavouriteModel(
      status: StatusModel.fromJson(json),
      products: fP,
    );
  }
}
