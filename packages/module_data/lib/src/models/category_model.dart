import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/src/models/spending_model.dart';

//TODO: add freezed

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required id,
    required owner,
    required name,
    required color,
    required spendings,
  }) : super(
          id: id,
          owner: owner,
          name: name,
          color: color,
          spendings: spendings,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        owner: json['owner'],
        name: json['name'],
        color: json['color'],
        spendings: const <SpendingModel>[],
      );

  factory CategoryModel.fromFirestore(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return CategoryModel.fromJson(json);
  }

  Map<String, Object?> toFirestore() {
    final data = {
      'owner': owner,
      'name': name,
      'color': color,
    };
    return data;
  }

  static CategoryModel fromEntity(CategoryEntity entity) {
    return CategoryModel(
      id: entity.id,
      owner: entity.owner,
      name: entity.name,
      color: entity.color,
      spendings: entity.spendings,
    );
  }

  CategoryModel copyWith({
    String? id,
    String? owner,
    String? name,
    String? color,
    List<SpendingModel>? spendings,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      name: name ?? this.name,
      color: color ?? this.color,
      spendings: spendings ?? this.spendings,
    );
  }
}
