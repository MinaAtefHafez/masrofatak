import 'package:masrofatak/core/helpers/hive_helper/hive_helper.dart';

abstract class CategoryRepo {
  Future<void> saveExpensesCategoriesLocal(List<dynamic> categories);
  Future<List<dynamic>> getExpensesCategoriesLocal();
  Future <void> saveIncomesCategoriesLocal(List<dynamic> categories);
  Future <List<dynamic>> getIncomesCategoriesLocal () ;
}

class CategoryRepoImpl extends CategoryRepo {
  @override
  Future<List<dynamic>> getExpensesCategoriesLocal() async {
    var data = await HiveHelper.getData(key: HiveConstants.expensesCategories);
    return data;
  }

  @override
  Future<void> saveExpensesCategoriesLocal(List<dynamic> categories) async {
    HiveHelper.putData(key: HiveConstants.expensesCategories, value: categories);
  }
  
  @override
  Future <List<dynamic>> getIncomesCategoriesLocal() async {
    var data = await HiveHelper.getData(key: HiveConstants.incomesCategories);
    return data;
  }
  
  @override
  Future<void> saveIncomesCategoriesLocal(List<dynamic> categories) async {
    HiveHelper.putData(key: HiveConstants.incomesCategories, value: categories);
  }
}
