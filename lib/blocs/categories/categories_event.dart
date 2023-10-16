part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class LoadCategoriesEvent extends CategoriesEvent {
  final Period period;

  const LoadCategoriesEvent({required this.period});

  @override
  List<Object?> get props => [period];
}

class UpdateCategoriesEvent extends CategoriesEvent {
  final Period period;

  const UpdateCategoriesEvent({required this.period});

  @override
  List<Object?> get props => [period];
}

class AddCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;

  const AddCategoryEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class RemoveCategoryEvent extends CategoriesEvent {
  final CategoryEntity category;

  const RemoveCategoryEvent({required this.category});

  @override
  List<Object?> get props => [category];
}

class AddSpendingEvent extends CategoriesEvent {
  final SpendingEntity spending;

  const AddSpendingEvent({required this.spending});

  @override
  List<Object?> get props => [spending];
}

class RemoveSpendingEvent extends CategoriesEvent {
  final SpendingEntity spending;

  const RemoveSpendingEvent({required this.spending});

  @override
  List<Object?> get props => [spending];
}
