import 'package:dartz/dartz.dart';
import 'package:module_business/module_business.dart';

class GetCategories {
  final SpendingsRepository spendingsRepository;

  const GetCategories(this.spendingsRepository);

  Future<Either<Failure, List<CategoryEntity>>> call(Period period) async {
    return await spendingsRepository.getCategories(period: period);
  }
}

class AddCategory {
  final SpendingsRepository spendingsRepository;

  const AddCategory(this.spendingsRepository);

  Future<Either<Failure, void>> call(CategoryEntity category) async {
    return await spendingsRepository.addCategory(category);
  }
}

class RemoveCategory {
  final SpendingsRepository spendingsRepository;

  const RemoveCategory(this.spendingsRepository);

  Future<Either<Failure, void>> call(CategoryEntity category) async {
    return await spendingsRepository.removeCategory(category);
  }
}

class AddSpending {
  final SpendingsRepository spendingsRepository;

  const AddSpending(this.spendingsRepository);

  Future<Either<Failure, void>> call(SpendingEntity spending) async {
    return await spendingsRepository.addSpending(spending);
  }
}

class RemoveSpending {
  final SpendingsRepository spendingsRepository;

  const RemoveSpending(this.spendingsRepository);

  Future<Either<Failure, void>> call(SpendingEntity spending) async {
    return await spendingsRepository.removeSpending(spending);
  }
}
