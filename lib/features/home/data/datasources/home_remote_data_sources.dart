import 'package:lafyuu/core/network/end_points.dart';
import '../../../../core/network/dio_helper.dart';
import '../models/home_model.dart';

abstract class HomeRemoteDataSources {
  Future<HomeModel> getHomeData();
}

class HomeRemoteDataSourcesImpl implements HomeRemoteDataSources {
  final DioHelper _dioHelper;
  HomeRemoteDataSourcesImpl(this._dioHelper);
  @override
  Future<HomeModel> getHomeData() async {
    final response = await _dioHelper.get(
      endPoint: homeEndPoint,
      token: token ?? '',
    );

    return HomeModel.fromJson(response);
  }
}
