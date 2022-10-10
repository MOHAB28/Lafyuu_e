import '../../../favourite/data/models/favourite_model.dart';
import '../../../home/data/models/home_model.dart';
import '../../domain/entities/search_entity.dart';

class SearchModel extends SearchEntity {
  final StatusModel? statusM;
  final SearchDataModel? searchDataM;
  SearchModel({
    this.searchDataM,
    this.statusM,
  }) : super(
          searchData: searchDataM!,
          status: statusM!,
        );

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      statusM: StatusModel.fromJson(json),
      searchDataM: SearchDataModel.fromJson(json['data']),
    );
  }
}

class SearchDataModel extends SearchDataEntity {
  final List<ProductsModel>? productsM;
  SearchDataModel({this.productsM}) : super(products: productsM!);

  factory SearchDataModel.fromJson(Map<String, dynamic> json) {
    List<ProductsModel> p = [];
    if (json['data'] != null) {
      for (var product in json['data']) {
        p.add(ProductsModel.fromJson(product));
      }
    }
    return SearchDataModel(
      productsM: p,
    );
  }
}
