part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object?> get props => [];
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class CategoriesLoading extends CategoriesState {
  @override
  List<Object?> get props => [];
}

class CategoriesLoaded extends CategoriesState {
  final List<CategoryEntity> categories;
  final bool noSpendings;
  final Period period;

  const CategoriesLoaded({
    required this.categories,
    required this.noSpendings,
    required this.period,
  });

  @override
  List<Object?> get props => [categories, noSpendings, period];
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
