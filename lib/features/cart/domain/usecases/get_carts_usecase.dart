import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cart_entity.dart';
import '../repositories/carts_repo.dart';

class GetCartsUsecase extends BaseUseCase<NoParams,CartEntity> {
  final CartsRepo _repo;
  GetCartsUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, CartEntity>> call(NoParams input) async {
    return await _repo.getCarts();
  }
}