import 'package:hive_flutter/adapters.dart';

import '../../../features/categories/data/models/categories_model.dart';
import '../../../features/expenses_income/data/models/expenses_income_model.dart';

abstract class HiveHelper {
  static late final Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<CategoryModel>(CategoryModelAdapter());
    Hive.registerAdapter<ExpensesIncomeModel>(ExpensesIncomeModelAdapter());
    box = await Hive.openBox(HiveConstants.box);
  }

  

  static bool isContainesKey(String key) {
    return box.containsKey(key);
  }

  static Future<void> putData<T>(
      {required String key, required T value}) async {
    await box.put(key, value);
  }

  static Future<dynamic> getData({required String key}) async {
    return box.get(key);
  }
}

abstract class HiveConstants {
  static const box = 'box';
  static const categories = 'categories';
  static const expensesIncome = 'expensesIncome';
}
