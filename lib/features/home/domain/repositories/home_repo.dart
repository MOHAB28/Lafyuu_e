import 'package:dartz/dartz.dart';
import '../../../../core/error/exception.dart';
import '../entities/home_entity.dart';

abstract class HomeDataRepo {
  Future<Either<PrimaryServerException,HomeEntity>> getHomeData();
}