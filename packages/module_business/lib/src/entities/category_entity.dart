import 'package:equatable/equatable.dart';
import 'package:module_business/src/entities/spending_entity.dart';

import 'package:flutter/material.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String owner;
  final String name;
  final String color;
  final List<SpendingEntity> spendings;

  const CategoryEntity({
    required this.id,
    required this.owner,
    required this.name,
    required this.color,
    required this.spendings,
  });

  @override
  List<Object?> get props => [id, owner, name, color, spendings];
}

extension CategoryExtension on CategoryEntity {
  double getTotalSpending() {
    double totalSpending = 0;
    for (final spending in spendings) {
      totalSpending += spending.amount;
    }
    return totalSpending;
  }

  Color getColor() {
    final hex = color;
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        // 0..9
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        //return AppTheme.accentColor;
      }
    }

    return Color(0xFF000000 + val);
  }
}
