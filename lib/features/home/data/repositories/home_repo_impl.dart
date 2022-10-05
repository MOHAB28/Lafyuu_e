import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/home_remote_data_sources.dart';
import '../../domain/entities/home_entity.dart';
import '../../domain/repositories/home_repo.dart';

class HomeDataRepoImpl implements HomeDataRepo {
  final HomeRemoteDataSources _remoteDataSources;
  final NetworkInfo _networkInfo;
  const HomeDataRepoImpl(this._remoteDataSources, this._networkInfo);

  @override
  Future<Either<PrimaryServerException, HomeEntity>> getHomeData() async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.getHomeData();
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
