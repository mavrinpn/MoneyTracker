import 'package:dartz/dartz.dart';
import 'package:diploma/core/helpers.dart';
import 'package:module_business/module_business.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final GetCategories getCategories;
  final AddCategory addCategory;
  final RemoveCategory removeCategory;
  final AddSpending addSpending;
  final RemoveSpending removeSpending;

  CategoriesBloc({
    required this.getCategories,
    required this.addCategory,
    required this.removeCategory,
    required this.addSpending,
    required this.removeSpending,
  }) : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>((event, emit) async {
      emit(CategoriesLoading());
      await loadCategories(event, emit);
    });

    on<UpdateCategoriesEvent>((event, emit) async {
      await loadCategories(event, emit);
    });

    on<AddCategoryEvent>((event, emit) async {
      final result = await addCategory(event.category);
      failureOrDone(result, emit);
    });

    on<RemoveCategoryEvent>((event, emit) async {
      final result = await removeCategory(event.category);
      failureOrDone(result, emit);
    });

    on<AddSpendingEvent>((event, emit) async {
      final result = await addSpending(event.spending);
      failureOrDone(result, emit);
    });

    on<RemoveSpendingEvent>((event, emit) async {
      final result = await removeSpending(event.spending);
      failureOrDone(result, emit);
    });
  }

  Future<void> loadCategories(event, emit) async {
    final failureOrCategories = await getCategories(event.period);
    failureOrCategories.fold((failure) {
      emit(CategoriesError(message: mapFailureToMessage(failure)));
    }, (categories) {
      double totalSpending = 0;
      for (var category in categories) {
        totalSpending += category.getTotalSpending();
      }

      emit(CategoriesLoaded(
        categories: categories,
        noSpendings: totalSpending == 0,
        period: event.period,
      ));
    });
  }

  void failureOrDone(Either<Failure, void> failureOrDone, emit) {
    failureOrDone.fold((failure) {
      emit(CategoriesError(message: mapFailureToMessage(failure)));
    }, (_) {
      if (state is CategoriesLoaded) {
        final currentState = state as CategoriesLoaded;
        add(UpdateCategoriesEvent(period: currentState.period));
      }
    });
  }
}
