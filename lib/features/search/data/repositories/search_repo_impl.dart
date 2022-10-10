import 'package:connectivity_plus/connectivity_plus.dart';

import '../../domain/entities/search_entity.dart';
import '../../../../core/error/exception.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/network_info.dart';
import '../datasources/search_remote_data_sources.dart';
import '../../domain/repositories/search_repo.dart';

class SearchRepoImpl implements SearchRepo {
  final NetworkInfo _networkInfo;
  final SearchRemoteDataSources _remoteDataSources;
  SearchRepoImpl(this._networkInfo, this._remoteDataSources);

  @override
  Future<Either<PrimaryServerException, SearchEntity>> search(
      String text) async {
    if (await _networkInfo.isConnected == ConnectivityResult.wifi ||
        await _networkInfo.isConnected == ConnectivityResult.mobile) {
      try {
        final response = await _remoteDataSources.search(text);
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
