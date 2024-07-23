abstract class CategoryState {}

final class InitialState extends CategoryState {}

final class SaveAllCategoriesLocal extends CategoryState {}

final class GeExpensesCategoriesLocal extends CategoryState {
  final List<dynamic> categories;

  GeExpensesCategoriesLocal(this.categories);
}

final class GetIncomesCategoriesLocal extends CategoryState {
  final List<dynamic> categories;

  GetIncomesCategoriesLocal(this.categories);
}

final class ChooseCategory extends CategoryState {}

final class ChooseExpensesOrIncomesToAddCategory extends CategoryState {}

final class AddToExpensesOrIncomes extends CategoryState {}

final class OnCategoryIconChanged extends CategoryState {}

final class RemoveCategory extends CategoryState {}
