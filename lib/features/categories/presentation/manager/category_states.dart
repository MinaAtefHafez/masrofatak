import '../../data/models/categories_model.dart';

abstract class CategoryState {}

final class InitialState extends CategoryState {}

final class SaveAllCategoriesLocal extends CategoryState {}

final class GeExpensesCategoriesLocal extends CategoryState {
  final List<CategoryModel> categories;

  GeExpensesCategoriesLocal(this.categories);
}


final class GetIncomesCategoriesLocal extends CategoryState {
  final List<CategoryModel> categories;

  GetIncomesCategoriesLocal(this.categories);
}

final class ChooseCategory extends CategoryState {}
