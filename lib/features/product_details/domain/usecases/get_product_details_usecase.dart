import '../../../../core/error/exception.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../home/domain/entities/home_entity.dart';
import '../repositories/product_details_repo.dart';

class GetProductDetailsUsecase extends BaseUseCase<int, ProductsEntity> {
  final ProductDetailsRepo _repo;
  GetProductDetailsUsecase(this._repo);
  @override
  Future<Either<PrimaryServerException, ProductsEntity>> call(int input) async {
    return await _repo.getProductDetails(input);
  }
}
