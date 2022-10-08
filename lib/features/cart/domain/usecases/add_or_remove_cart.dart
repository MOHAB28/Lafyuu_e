import 'package:dartz/dartz.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/carts_repo.dart';

class AddOrRemoveCartUsecase extends BaseUseCase<int,StatusEntity> {
  final CartsRepo _repo;
  AddOrRemoveCartUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, StatusEntity>> call(int input) async {
    return await _repo.addOrRemoveCart(input);
  }
}