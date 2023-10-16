import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/src/models/category_model.dart';
import 'package:module_data/src/models/spending_model.dart';

class FirebaseFirestoreService {
  final categoriesCollection = FirebaseFirestore.instance
      .collection('categories')
      .withConverter<CategoryModel>(
          fromFirestore: (snapshot, _) => CategoryModel.fromFirestore(snapshot),
          toFirestore: (object, _) => object.toFirestore());

  final spendingsCollection = FirebaseFirestore.instance
      .collection('spendings')
      .withConverter<SpendingModel>(
          fromFirestore: (snapshot, _) => SpendingModel.fromFirestore(snapshot),
          toFirestore: (object, _) => object.toFirestore());

  Future<List<CategoryModel>> getCategories({
    required String userUid,
    required Period period,
  }) async {
    final startDate = period.startDate();
    final endDate = period.endDate();

    final spendingsSnapshot = await spendingsCollection
        .where('owner', isEqualTo: userUid)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: endDate)
        .orderBy('date')
        .get();
    final spendings = spendingsSnapshot.docs.map((e) => e.data()).toList();

    final categoriesSnapshot = await categoriesCollection
        .where('owner', isEqualTo: userUid)
        .orderBy('name')
        .get();
    final categories = categoriesSnapshot.docs.map((e) => e.data()).toList();

    for (var i = 0; i < categories.length; i++) {
      final categorySpendings = spendings
          .where((element) => element.categoryId == categories[i].id)
          .toList();

      categories[i] = categories[i].copyWith(spendings: categorySpendings);
    }
    return categories;
  }

  Future<void> addCategory(CategoryModel category) {
    return categoriesCollection.add(category);
  }

  Future<void> addSpending(SpendingModel spending) {
    return spendingsCollection.add(spending);
  }

  Future<void> removeCategory({
    required String userUid,
    required CategoryModel category,
  }) async {
    final batch = FirebaseFirestore.instance.batch();

    final spendings = await spendingsCollection
        .where('owner', isEqualTo: userUid)
        .where('categoryId', isEqualTo: category.id)
        .get();

    for (final doc in spendings.docs) {
      batch.delete(doc.reference);
    }
    batch.delete(categoriesCollection.doc(category.id));
    return batch.commit();
  }

  Future<void> removeSpending(SpendingModel spending) {
    return spendingsCollection.doc(spending.id).delete();
  }
}
