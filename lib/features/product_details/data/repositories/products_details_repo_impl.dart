import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/network/network_info.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../../domain/repositories/product_details_repo.dart';
import '../datasources/product_details_remote_data_sources.dart';

class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final NetworkInfo _networkInfo;
  final ProductDetailsRemoteDataSources _remoteDataSources;
  ProductDetailsRepoImpl(this._networkInfo, this._remoteDataSources);
  @override
  Future<Either<PrimaryServerException, ProductsEntity>> getProductDetails(
      int id) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.getProductDetails(id);
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
