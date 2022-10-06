import 'package:equatable/equatable.dart';

class StatusEntity extends Equatable {
  final String message;
  final bool status;
  const StatusEntity({
    required this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [message, status];
}

class FavProductsEntity extends Equatable {
  final List<FavouriteProductEntity> products;
  const FavProductsEntity({
    required this.products,
  });
  
  @override
  List<Object?> get props => [products];
}

class FavouriteEntity extends Equatable {
  final StatusEntity status;
  final FavProductsEntity favProductsEntity;
  const FavouriteEntity({
    required this.status,
    required this.favProductsEntity,
  });

  @override
  List<Object?> get props => [status, favProductsEntity];
}

class FavouriteProductEntity extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  const FavouriteProductEntity({
    required this.description,
    required this.discount,
    required this.id,
    required this.image,
    required this.name,
    required this.oldPrice,
    required this.price,
  });

  @override
  List<Object?> get props => [
        description,
        discount,
        id,
        image,
        name,
        oldPrice,
        price,
      ];
}
