import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';

class SearchEntity extends Equatable {
  final StatusEntity status;
  final SearchDataEntity searchData;
  const SearchEntity({
    required this.searchData,
    required this.status,
  });

  @override
  List<Object?> get props => [
        searchData,
        status,
      ];
}

class SearchDataEntity extends Equatable {
  final List<ProductsEntity> products;
  const SearchDataEntity({
    required this.products,
  });
  
  @override
  List<Object?> get props => [
    products,
  ];
}