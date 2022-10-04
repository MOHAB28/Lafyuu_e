import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/end_points.dart';
import '../../domain/repositories/login_repo.dart';
import '../models/login_model.dart';

abstract class LoginRemoteDataSources {
  Future<AuthModel> login(LoginInput input);
}

class LoginRemoteDataSourcesImpl implements LoginRemoteDataSources {
  final DioHelper _dioHelper;
  LoginRemoteDataSourcesImpl(this._dioHelper);

  @override
  Future<AuthModel> login(LoginInput input) async {
    final response = await _dioHelper.post(
      endPoint: loginEndPoint,
      data: {
        'email': input.email,
        'password': input.password,
      },
    );

    return AuthModel.fromJson(response);
  }
}
