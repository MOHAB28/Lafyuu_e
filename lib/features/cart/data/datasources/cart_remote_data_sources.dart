import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/cart_model.dart';
import '../../../favourite/data/models/favourite_model.dart';

abstract class CartRemoteDataSources {
  Future<CartModel> getCarts();
  Future<StatusModel> addOrRemoveCart(int id);
  Future<StatusModel> updateCart(int id);
}

class CartRemoteDataSourcesImpl implements CartRemoteDataSources {
  final DioHelper _dioHelper;
  CartRemoteDataSourcesImpl(this._dioHelper);

  @override
  Future<StatusModel> addOrRemoveCart(int id) async {
    final response = await _dioHelper.post(
      endPoint: cartsEndPoint,
      token: token ?? '',
      data: {
        'product_id': id,
      },
    );

    return StatusModel.fromJson(response);
  }

  @override
  Future<CartModel> getCarts() async {
    final response = await _dioHelper.get(
      endPoint: cartsEndPoint,
      token: token ?? '',
    );

    return CartModel.fromJson(response);
  }

  @override
  Future<StatusModel> updateCart(int id) async {
    final response = await _dioHelper.put(
      endPoint: '$cartsEndPoint/$id',
      token: token ?? '',
    );

    return StatusModel.fromJson(response);
  }
}
