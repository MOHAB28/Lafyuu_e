import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/home_entity.dart';
import '../repositories/home_repo.dart';

class HomeDataUsecase extends BaseUseCase<NoParams, HomeEntity> {
  final HomeDataRepo _repo;
  HomeDataUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, HomeEntity>> call(NoParams input) async {
    return await _repo.getHomeData();
  }
}
