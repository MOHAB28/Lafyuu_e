import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/cart_entity.dart';
import '../repositories/carts_repo.dart';

class AddOrRemoveCartUsecase extends BaseUseCase<int,CartItemDataEntity> {
  final CartsRepo _repo;
  AddOrRemoveCartUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, CartItemDataEntity>> call(int input) async {
    return await _repo.addOrRemoveCart(input);
  }
}