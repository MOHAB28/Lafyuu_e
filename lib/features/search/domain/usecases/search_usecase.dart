import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../entities/search_entity.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/search_repo.dart';

class SearchUsecase extends BaseUseCase<String,SearchEntity> {
  final SearchRepo _repo;
  SearchUsecase(this._repo);

  @override
  Future<Either<PrimaryServerException, SearchEntity>> call(String input) async {
    return await _repo.search(input);
  }
}