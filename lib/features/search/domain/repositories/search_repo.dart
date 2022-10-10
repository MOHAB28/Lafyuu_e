import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../entities/search_entity.dart';

abstract class SearchRepo {
  Future<Either<PrimaryServerException,SearchEntity>> search(String text);
}