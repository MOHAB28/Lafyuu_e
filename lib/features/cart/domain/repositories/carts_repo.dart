import 'package:dartz/dartz.dart';
import '../../../favourite/domain/entities/favourite_entity.dart';
import '../../../../core/error/exception.dart';
import '../entities/cart_entity.dart';

abstract class CartsRepo {
  Future<Either<PrimaryServerException, CartEntity>> getCarts();
  Future<Either<PrimaryServerException, StatusEntity>> addOrRemoveCart(int id);
  Future<Either<PrimaryServerException, StatusEntity>> updateCart(int id);
}
