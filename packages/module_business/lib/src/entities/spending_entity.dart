import 'package:equatable/equatable.dart';

class SpendingEntity extends Equatable {
  final String id;
  final DateTime date;
  final double amount;
  final String categoryId;

  const SpendingEntity({
    required this.id,
    required this.date,
    required this.amount,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [id, date, amount, categoryId];
}
