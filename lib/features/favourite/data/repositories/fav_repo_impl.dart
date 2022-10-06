import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/favourite_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/favourite_remote_data_sources.dart';
import '../../domain/repositories/fav_repo.dart';

class FavouriteRepoImpl extends FavouritreRepo {
  final NetworkInfo _networkInfo;
  final FavouriteRemoteDataSources _remoteDataSources;
  FavouriteRepoImpl(this._networkInfo, this._remoteDataSources);
  @override
  Future<Either<PrimaryServerException, StatusEntity>> addOrRemoveToFavs(
      int id) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.addOrRemoveFav(id);
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
  Future<Either<PrimaryServerException, FavouriteEntity>>
      getFavourites() async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.getAllFavourites();
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
