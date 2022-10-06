import '../../../../core/error/exception.dart';
import 'package:dartz/dartz.dart';
import '../repositories/fav_repo.dart';
import '../entities/favourite_entity.dart';
import '../../../../core/usecase/usecase.dart';

class AddOrRemoveFavUsecsae extends BaseUseCase<int, StatusEntity> {
  final FavouritreRepo _repo;
  AddOrRemoveFavUsecsae(this._repo);

  @override
  Future<Either<PrimaryServerException, StatusEntity>> call(int input) async {
    return await _repo.addOrRemoveToFavs(input);
  }
}
