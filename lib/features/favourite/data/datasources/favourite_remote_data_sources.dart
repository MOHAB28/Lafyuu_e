import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../models/favourite_model.dart';

abstract class FavouriteRemoteDataSources {
  Future<FavouriteModel> getAllFavourites();
  Future<StatusModel> addOrRemoveFav(int id);
}

class FavouriteRemoteDataSourcesImpl implements FavouriteRemoteDataSources {
  final DioHelper _dioHelper;
  FavouriteRemoteDataSourcesImpl(this._dioHelper);
  @override
  Future<StatusModel> addOrRemoveFav(int id) async {
    final response = await _dioHelper.post(
      endPoint: favoritesEndPoint,
      token: token ?? '',
      data: {
        'product_id': id,
      },
    );

    return StatusModel.fromJson(response);
  }

  @override
  Future<FavouriteModel> getAllFavourites() async {
    final response = await _dioHelper.get(
      endPoint: favoritesEndPoint,
      token: token ?? '',
    );

    return FavouriteModel.fromJson(response);
  }
}
