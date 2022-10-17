import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../domain/repositories/carts_repo.dart';
import '../models/cart_model.dart';
import '../../../favourite/data/models/favourite_model.dart';

abstract class CartRemoteDataSources {
  Future<CartModel> getCarts();
  Future<CartItemDataModel> addOrRemoveCart(int id);
  Future<StatusModel> updateCart(UpdateCartInput input);
}

class CartRemoteDataSourcesImpl implements CartRemoteDataSources {
  final DioHelper _dioHelper;
  CartRemoteDataSourcesImpl(this._dioHelper);

  @override
  Future<CartItemDataModel> addOrRemoveCart(int id) async {
    final response = await _dioHelper.post(
      endPoint: cartsEndPoint,
      token: token ?? '',
      data: {
        'product_id': id,
      },
    );

    return CartItemDataModel.fromJson(response['data']);
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
  Future<StatusModel> updateCart(UpdateCartInput input) async {
    final response = await _dioHelper.put(
      endPoint: '$cartsEndPoint/${input.id}',
      token: token ?? '',
      data: {
        'quantity' : input.quantity,
      }
    );

    return StatusModel.fromJson(response);
  }
}
