import 'package:hive/hive.dart';

import '../../../features/categories/data/models/categories_model.dart';
import '../../../features/expenses_income/data/models/expenses_income_model.dart';

abstract class HiveAdapters {
  static List<TypeAdapter> adapters = [
    CategoryModelAdapter(),
    ExpensesIncomeModelAdapter(),
  ];
}
