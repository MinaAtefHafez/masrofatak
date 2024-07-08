import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/categories/data/models/categories_model.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';
import 'package:masrofatak/features/search/presentation/manager/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());

  List<CategoryModel> expensesCategories = [];
  List<CategoryModel> incomesCategories = [];
  List<CategoryModel> allCategories = [];
  Map<String, bool> searchMap = {};
  List<ExpensesIncomeModel> expensesIncomes = [];
  List<ExpensesIncomeModel> searchList = [];

  Future<void> getExpensesIncomesFromExpensesCubit(
      List expensesIncomesList) async {
    expensesIncomes = List.from(expensesIncomesList);
  }

  Future<void> getExpensesCategoriesFromCategoryCubit(List categories) async {
    expensesCategories = List.from(categories);
  }

  Future<void> getIncomesCategoriesFromCategoryCubit(List categories) async {
    incomesCategories = List.from(categories);
  }

  Future<void> mergeIncomesAndExpensesCategories() async {
    allCategories = List.from(expensesCategories)..addAll(incomesCategories);
  }

  bool get isSearchMapContainsTrue {
    return searchMap.containsValue(true);
  }

  Future<void> initSearchMap() async {
    searchMap.clear();
    for (var e in allCategories) {
      searchMap.addAll({e.name!: false});
    }
    emit(InitSearchMap());
  }

  Future<void> clearSearchList() async {
    searchList.clear();
    emit(ClearSearchList());
  }

  Future<void> chooseCategoryFromMap(String value) async {
    searchMap[value] = !searchMap[value]!;
    emit(ChooseItemFromSearchMap());
  }

  Future<void> searchOnItem(String text) async {
    searchList =
        expensesIncomes.where((e) => e.description!.contains(text)).toList();
    emit(FilterSearchListAccordingSearchText());
  }

  Future<void> searchOnSearchMapContainsTrue(String text) async {
    searchList = expensesIncomes
        .where((e) =>
            e.description!.contains(text) && searchMap[e.category!.name]!)
        .toList();
    emit(FilterSearchListAccordingSearchText());
  }

  Future<void> search(String text) async {
    if (isSearchMapContainsTrue) {
      await searchOnSearchMapContainsTrue(text);
    } else {
      await searchOnItem(text);
    }
  }
}
