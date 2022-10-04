import '../../../../core/network/end_points.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../login/data/models/login_model.dart';
import '../../domain/repositories/register_repo.dart';

abstract class RegisterRemoteDataSources {
  Future<AuthModel> register(RegisterInput input);
}

class RegisterRemoteDataSourcesImpl implements RegisterRemoteDataSources {
  final DioHelper _dioHelper;
  RegisterRemoteDataSourcesImpl(this._dioHelper);
  @override
  Future<AuthModel> register(RegisterInput input) async {
    final response = await _dioHelper.post(
      endPoint: registerEndPoint,
      data: {
        'name': input.name,
        'email': input.email,
        'password': input.password,
        'phone': input.phone,
      },
    );

    return AuthModel.fromJson(response);
  }
}
