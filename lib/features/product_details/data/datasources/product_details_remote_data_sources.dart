import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../../home/data/models/home_model.dart';

abstract class ProductDetailsRemoteDataSources {
  Future<ProductsModel> getProductDetails(int id);
}

class ProductDetailsRemoteDataSourcesImpl
    implements ProductDetailsRemoteDataSources {
  final DioHelper _dio;
  ProductDetailsRemoteDataSourcesImpl(this._dio);

  @override
  Future<ProductsModel> getProductDetails(int id) async {
    final response = await _dio.get(
      endPoint: '$productsDetailsEndPoint/$id',
      token: token ?? '',
    );
    return ProductsModel.fromJson(response['data']);
  }
}
