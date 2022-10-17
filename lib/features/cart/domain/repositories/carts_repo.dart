import 'package:dartz/dartz.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../../../core/error/exception.dart';
import '../entities/cart_entity.dart';

abstract class CartsRepo {
  Future<Either<PrimaryServerException, CartEntity>> getCarts();
  Future<Either<PrimaryServerException, CartItemDataEntity>> addOrRemoveCart(int id);
  Future<Either<PrimaryServerException, StatusEntity>> updateCart(UpdateCartInput input);
}

class UpdateCartInput {
  final int id;
  final int quantity;
  const UpdateCartInput({
    required this.id,
    required this.quantity,
  });
}