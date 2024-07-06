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
  @HiveField(6)
  String? dateTime;
  @HiveField(7)
  String? year;

  ExpensesIncomeModel(
      {this.month,
      this.day,
      this.type,
      this.category,
      this.amount,
      this.description,
      this.dateTime,
      this.year});

  ExpensesIncomeModel copyWith({
    CategoryModel? category,
    int? amount,
    String? description,
    String? day,
    String? month,
    String? type,
    String? dateTime,
    String? year,
  }) {
    return ExpensesIncomeModel(
      category: category ?? this.category,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      day: day ?? this.day,
      month: month ?? this.month,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      year: year ?? this.year,
    );
  }
}
