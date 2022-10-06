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

class FavouriteEntity extends Equatable {
  final StatusEntity status;
  final List<FavouriteProductEntity> products;
  const FavouriteEntity({
    required this.status,
    required this.products,
  });

  @override
  List<Object?> get props => [status, products];
}

class FavouriteProductEntity extends Equatable {
  final int id;
  final String image;
  final String name;
  final String description;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
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
