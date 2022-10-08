import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../domain/entities/cart_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/cart_remote_data_sources.dart';
import '../../domain/repositories/carts_repo.dart';

class CartsRepoImpl implements CartsRepo {
  final NetworkInfo _networkInfo;
  final CartRemoteDataSources _remoteDataSources;
  CartsRepoImpl(this._networkInfo, this._remoteDataSources);

  @override
  Future<Either<PrimaryServerException, StatusEntity>> addOrRemoveCart(
      int id) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.addOrRemoveCart(id);
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
  Future<Either<PrimaryServerException, CartEntity>> getCarts() async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.getCarts();
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
  Future<Either<PrimaryServerException, StatusEntity>> updateCart(
      int id) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.updateCart(id);
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
