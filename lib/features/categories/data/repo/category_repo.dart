import 'package:masrofatak/core/helpers/hive_helper/hive_helper.dart';
import 'package:masrofatak/features/categories/data/models/categories_model.dart';

abstract class CategoryRepo {
  Future<void> saveAllCategoriesLocal(List<CategoryModel> categories);
  Future<dynamic> getAllCategoriesLocal();
}

class CategoryRepoImpl extends CategoryRepo {
  @override
  Future<dynamic> getAllCategoriesLocal() async {
    var data = await HiveHelper.getData(key: HiveConstants.categories);
    return data;
  }

  @override
  Future<void> saveAllCategoriesLocal(List<CategoryModel> categories) async {
    HiveHelper.putData(key: HiveConstants.categories, value: categories);
  }
}
