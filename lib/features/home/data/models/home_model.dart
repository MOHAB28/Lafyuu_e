import '../../domain/entities/home_entity.dart';

class HomeModel extends HomeEntity {
  final HomeDataModel? homeDataModel;
  HomeModel({
    bool? status,
    String? message,
    this.homeDataModel,
  }) : super(
          homeData: homeDataModel!,
          message: message!,
          status: status!,
        );

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status: json['status'],
      message: json['message'] ?? '',
      homeDataModel:
          json['data'] != null ? HomeDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'status': status,
      'message': message,
      'data': homeDataModel != null ? homeDataModel!.toJson() : null,
    };
    return json;
  }
}

class HomeDataModel extends HomeDataEntity {
  final List<BannersModel>? bannersModel;
  final List<ProductsModel>? productsModel;
  HomeDataModel({
    this.bannersModel,
    this.productsModel,
    String? ad,
  }) : super(
          ad: ad!,
          banners: bannersModel!,
          products: productsModel!,
        );

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    List<BannersModel> bannersM = [];
    List<ProductsModel> productsM = [];
    if (json['banners'] != null) {
      for (var banner in json['banners']) {
        bannersM.add(BannersModel.fromJson(banner));
      }
    }
    if (json['products'] != null) {
      for (var product in json['products']) {
        productsM.add(ProductsModel.fromJson(product));
      }
    }
    return HomeDataModel(
      ad: json['ad'],
      bannersModel: bannersM,
      productsModel: productsM,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'banners': bannersModel != null
          ? bannersModel!.map((banner) => banner.toJson()).toList()
          : [],
      'products': productsModel != null
          ? productsModel!.map((product) => product.toJson()).toList()
          : [],
      '': ad
    };
    return json;
  }
}

class BannersModel extends BannerEntity {
  BannersModel({
    String? image,
    int? id,
  }) : super(
          image: image!,
          id: id!,
        );
  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'image': image,
    };
    return json;
  }
}

class ProductsModel extends ProductsEntity {
  ProductsModel({
    int? id,
    dynamic price,
    dynamic oldPrice,
    int? discount,
    String? image,
    String? name,
    String? description,
    List<String>? images,
    bool? inFav,
    bool? inCart,
  }) : super(
          image: image!,
          id: id!,
          price: price,
          oldPrice: oldPrice,
          description: description!,
          discount: discount!,
          images: images!,
          inCart: inCart!,
          inFav: inFav!,
          name: name!,
        );
  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    if (json['images'] != null) {
      for (String image in json['images']) {
        images.add(image);
      }
    }
    return ProductsModel(
      id: json['id'],
      price: json['price'],
      oldPrice: json['old_price'],
      discount: json['discount'],
      image: json['image'],
      name: json['name'],
      description: json['description'],
      images: images,
      inFav: json['in_favorites'],
      inCart: json['in_cart'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'price': price,
      'old_price': oldPrice,
      'discount': discount,
      'image': image,
      'name': name,
      'description': description,
      'in_favorites': inFav,
      'in_cart': inCart,
      'images': images.map((image) => image).toList()
    };
    return json;
  }
}
