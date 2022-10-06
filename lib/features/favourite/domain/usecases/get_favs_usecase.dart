import 'package:lafyuu/core/error/exception.dart';
import 'package:dartz/dartz.dart';
import '../repositories/fav_repo.dart';
import '../entities/favourite_entity.dart';
import '../../../../core/usecase/usecase.dart';

class GetAllFavouritesUsecase extends BaseUseCase<NoParams,FavouriteEntity> {
  final FavouritreRepo _repo;
  GetAllFavouritesUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, FavouriteEntity>> call(NoParams input) async {
    return await _repo.getFavourites();
  }
}