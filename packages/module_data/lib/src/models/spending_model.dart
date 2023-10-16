import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:module_business/module_business.dart';

class SpendingModel extends SpendingEntity {
  final String owner;

  const SpendingModel({
    required id,
    required date,
    required amount,
    required categoryId,
    required this.owner,
  }) : super(
          id: id,
          date: date,
          amount: amount,
          categoryId: categoryId,
        );

  factory SpendingModel.fromJson(Map<String, dynamic> json) => SpendingModel(
        id: json['id'],
        date: const TimestampConverter().fromJson(json['date'] as Timestamp),
        amount: json['amount'],
        categoryId: json['categoryId'],
        owner: json['owner'],
      );

  Map<String, dynamic> toJson(SpendingModel instance) => <String, dynamic>{
        'id': instance.id,
        'date': const TimestampConverter().toJson(instance.date),
        'amount': instance.amount,
        'categoryId': instance.categoryId,
        'owner': instance.owner,
      };

  factory SpendingModel.fromFirestore(DocumentSnapshot snapshot) {
    final json = snapshot.data() as Map<String, dynamic>;
    json['id'] = snapshot.id;
    return SpendingModel.fromJson(json);
  }

  Map<String, Object?> toFirestore() {
    final data = {
      'date': date,
      'amount': amount,
      'categoryId': categoryId,
      'owner': owner,
    };
    return data;
  }

  static SpendingModel fromEntity(SpendingEntity entity) {
    return SpendingModel(
      id: entity.id,
      owner: '',
      date: entity.date,
      categoryId: entity.categoryId,
      amount: entity.amount,
    );
  }

  SpendingModel copyWith({
    String? id,
    String? owner,
    DateTime? date,
    String? categoryId,
    double? amount,
  }) {
    return SpendingModel(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      date: date ?? this.date,
      categoryId: categoryId ?? this.categoryId,
      amount: amount ?? this.amount,
    );
  }
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp value) => value.toDate();

  @override
  Timestamp toJson(DateTime value) => Timestamp.fromDate(value);
}
