import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../../core/error/exception.dart';
import '../../../register/domain/repositories/register_repo.dart';
import '../../../login/domain/entities/login_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/profile_remote_data_sources.dart';
import '../../domain/repositories/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;
  ProfileRepoImpl(this._networkInfo, this._remoteDataSources);

  @override
  Future<Either<PrimaryServerException, AuthEntity>> getProfileData() async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
        try {
        final response = await _remoteDataSources.getProfileData();
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

  @override
  Future<Either<PrimaryServerException, AuthEntity>> updataProfile(RegisterInput input) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
       try {
        final response = await _remoteDataSources.updataProfileData(input);
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
