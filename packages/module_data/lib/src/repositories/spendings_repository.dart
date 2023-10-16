import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/src/core/exception.dart';
import 'package:module_data/src/models/category_model.dart';
import 'package:module_data/src/models/spending_model.dart';
import 'package:module_data/src/services/firebase_auth_service.dart';
import 'package:module_data/src/services/firebase_firestore_service.dart';

class SpendingsRepositoryImp implements SpendingsRepository {
  FirebaseAuthService authService = FirebaseAuthService();
  FirebaseFirestoreService storeService = FirebaseFirestoreService();

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories({
    required Period period,
  }) async {
    try {
      final userUid = authService.getCurrentUserUid();
      final data =
          await storeService.getCategories(userUid: userUid, period: period);
      return Right(data);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryEntity category) async {
    try {
      final userUid = authService.getCurrentUserUid();
      final categoryModel = CategoryModel.fromEntity(category);
      final owneredCategory = categoryModel.copyWith(owner: userUid);
      storeService.addCategory(owneredCategory);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addSpending(SpendingEntity spending) async {
    try {
      final userUid = authService.getCurrentUserUid();
      final spendingModel = SpendingModel.fromEntity(spending);
      final owneredSpending = spendingModel.copyWith(owner: userUid);
      storeService.addSpending(owneredSpending);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeCategory(CategoryEntity category) async {
    try {
      final userUid = authService.getCurrentUserUid();
      storeService.removeCategory(
          userUid: userUid, category: category as CategoryModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeSpending(SpendingEntity spending) async {
    try {
      storeService.removeSpending(spending as SpendingModel);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
