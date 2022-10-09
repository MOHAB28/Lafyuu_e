import 'package:dartz/dartz.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/carts_repo.dart';

class UpdateCartUsecase
    extends BaseUseCase<UpdateCartUsecaseInput, StatusEntity> {
  final CartsRepo _repo;
  UpdateCartUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, StatusEntity>> call(
      UpdateCartUsecaseInput input) async {
    return await _repo.updateCart(
      UpdateCartInput(
        id: input.id,
        quantity: input.quantity,
      ),
    );
  }
}

class UpdateCartUsecaseInput {
  final int id;
  final int quantity;
  const UpdateCartUsecaseInput({
    required this.id,
    required this.quantity,
  });
}
