import 'package:dartz/dartz.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/register_repo.dart';
import '../datasources/register_remote_data_sources.dart';

class RegisterRepoImpl implements RegisterRepo {
  final RegisterRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;
  const RegisterRepoImpl(this._networkInfo, this._remoteDataSources);

  @override
  Future<Either<PrimaryServerException, AuthEntity>> register(
      RegisterInput input) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.register(input);
        return Right(response);
      } catch (error) {
        return Left(
          PrimaryServerException(
            code: 0,
            error: 'SomeThing wrong',
            message: error.toString(),
          ),
        );
      }
    } else {
      return const Left(
        PrimaryServerException(
          code: 500,
          error: 'No Internet Connection',
          message: 'Please check your internet connection!',
        ),
      );
    }
  }
}
