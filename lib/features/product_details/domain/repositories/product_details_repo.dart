import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../../../home/domain/entities/home_entity.dart';

abstract class ProductDetailsRepo {
  Future<Either<PrimaryServerException,ProductsEntity>> getProductDetails(int id);
}