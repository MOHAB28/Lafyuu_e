import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repo.dart';
import '../datasources/login_remote_data_sources.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;
  const LoginRepoImpl(this._networkInfo, this._remoteDataSources);

  @override
  Future<Either<PrimaryServerException, AuthEntity>> login(
      LoginInput input) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.login(input);
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
