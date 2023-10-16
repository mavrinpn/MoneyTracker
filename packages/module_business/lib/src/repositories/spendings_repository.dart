import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';

abstract class SpendingsRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories(
      {required Period period});
  Future<Either<Failure, void>> addCategory(CategoryEntity category);
  Future<Either<Failure, void>> removeCategory(CategoryEntity category);
  Future<Either<Failure, void>> addSpending(SpendingEntity spending);
  Future<Either<Failure, void>> removeSpending(SpendingEntity spending);
}
