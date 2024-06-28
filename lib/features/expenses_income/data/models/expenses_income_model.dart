// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive_flutter/adapters.dart';

import 'package:masrofatak/features/categories/data/models/categories_model.dart';

part 'expenses_income_model.g.dart';

@HiveType(typeId: 1)
class ExpensesIncomeModel extends HiveObject {
  @HiveField(0)
  CategoryModel? category;
  @HiveField(1)
  int? amount;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String? day;
  @HiveField(4)
  String? month;
  @HiveField(5)
  String? type;

  ExpensesIncomeModel({
    this.month,
    this.day,
    this.type,
    this.category,
    this.amount,
    this.description,
  });

  ExpensesIncomeModel copyWith({
    CategoryModel? category,
    int? amount,
    String? description,
    String? day,
    String? month,
    String? type,
  }) {
    return ExpensesIncomeModel(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      day: day ?? this.day,
      month: month ?? this.month,
      type: type ?? this.type,
    );
  }
}
