import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../entities/favourite_entity.dart';

abstract class FavouritreRepo {
  Future<Either<PrimaryServerException, FavouriteEntity>> getFavourites();
  Future<Either<PrimaryServerException, StatusEntity>> addOrRemoveToFavs(int id);
}
