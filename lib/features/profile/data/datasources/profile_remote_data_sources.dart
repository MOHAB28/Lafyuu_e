import '../../../../core/network/end_points.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../register/domain/repositories/register_repo.dart';
import '../../../login/data/models/login_model.dart';

abstract class ProfileRemoteDataSources {
  Future<AuthModel> getProfileData();
  Future<AuthModel> updataProfileData(RegisterInput input);
}

class ProfileRemoteDataSourcesImpl implements ProfileRemoteDataSources {
  final DioHelper _dioHelper;
  ProfileRemoteDataSourcesImpl(this._dioHelper);
  @override
  Future<AuthModel> getProfileData() async {
    final response = await _dioHelper.get(
      endPoint: profileEndPoint,
      token: token ?? '',
    );

    return AuthModel.fromJson(response);
  }

  @override
  Future<AuthModel> updataProfileData(RegisterInput input) async {
    final response = await _dioHelper.put(
      endPoint: updateProfileEndPoint,
      data: {
        'name': input.name,
        'email': input.email,
        'phone': input.phone,
      },
      token: token ?? '',
    );

    return AuthModel.fromJson(response);
  }
}
