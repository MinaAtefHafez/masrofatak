import 'package:masrofatak/core/helpers/hive_helper/hive_helper.dart';
import 'package:masrofatak/features/categories/data/models/categories_model.dart';

abstract class CategoryRepo {
  Future<void> saveExpensesCategoriesLocal(List<CategoryModel> categories);
  Future<dynamic> getExpensesCategoriesLocal();
  Future <void> saveIncomesCategoriesLocal(List<CategoryModel> categories);
  Future <dynamic> getIncomesCategoriesLocal () ;
}

class CategoryRepoImpl extends CategoryRepo {
  @override
  Future<dynamic> getExpensesCategoriesLocal() async {
    var data = await HiveHelper.getData(key: HiveConstants.expensesCategories);
    return data;
  }

  @override
  Future<void> saveExpensesCategoriesLocal(List<CategoryModel> categories) async {
    HiveHelper.putData(key: HiveConstants.expensesCategories, value: categories);
  }
  
  @override
  Future <dynamic> getIncomesCategoriesLocal() async {
    var data = await HiveHelper.getData(key: HiveConstants.incomesCategories);
    return data;
  }
  
  @override
  Future<void> saveIncomesCategoriesLocal(List<CategoryModel> categories) async {
    HiveHelper.putData(key: HiveConstants.incomesCategories, value: categories);
  }
}
