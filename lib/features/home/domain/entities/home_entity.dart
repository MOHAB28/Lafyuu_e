import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  final bool status;
  final String message;
  final HomeDataEntity homeData;

  const HomeEntity({
    required this.homeData,
    required this.message,
    required this.status,
  });

  @override
  List<Object?> get props => [
        homeData,
        message,
        status,
      ];
}

class HomeDataEntity extends Equatable {
  final List<BannerEntity> banners;
  final List<ProductsEntity> products;
  final String ad;

  const HomeDataEntity({
    required this.ad,
    required this.banners,
    required this.products,
  });

  @override
  List<Object?> get props => [
        ad,
        banners,
        products,
      ];
}

class BannerEntity extends Equatable {
  final String image;
  final int id;

  const BannerEntity({
    required this.id,
    required this.image,
  });

  @override
  List<Object?> get props => [
        id,
        image,
      ];
}

class ProductsEntity extends Equatable {
  final int id;
  final dynamic price;
  final dynamic oldPrice;
  final int discount;
  final String image;
  final String name;
  final String description;
  final List<String> images;
  final bool inFav;
  final bool inCart;

  const ProductsEntity({
    required this.description,
    required this.discount,
    required this.id,
    required this.image,
    required this.images,
    required this.inCart,
    required this.inFav,
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
        images,
        inCart,
        inFav,
        name,
        oldPrice,
        price,
      ];
}
