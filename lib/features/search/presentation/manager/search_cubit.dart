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

  Future<void> initSearchMap() async {
    searchMap.clear();
    for (var e in allCategories) {
      searchMap.addAll({e.name!: false});
    }
    emit(InitSearchMap());
  }

  bool get isSearchMapContainsOnTrue {
    return searchMap.containsValue(true);
  }

  Future<void> clearSearchList() async {
    searchList.clear();
  }

  Future<void> chooseCategoryFromMap(String value) async {
    searchMap[value] = !searchMap[value]!;
    emit(ChooseItemFromSearchMap());
  }

  Future<void> filterSearchListAccordingCategories() async {
    searchList =
        expensesIncomes.where((e) => searchMap[e.category!.name]!).toList();
    emit(FilterSearchListAccordingCategories());
  }

  Future<List<ExpensesIncomeModel>> searchOnItem(String text,
      {required List<ExpensesIncomeModel> list}) async {
    list = list.where((e) => e.description!.contains(text)).toList();
    return list;
  }

  Future<void> searchInSearchList(String text) async {
    searchList = await searchOnItem(text, list: searchList);
    emit(FilterSearchListAccordingSearchText());
  }

  Future<void> searchOnExpensesIncomesList(String text) async {
    searchList = await searchOnItem(text, list: expensesIncomes);
    emit(FilterSearchListAccordingSearchText());
  }

  Future<void> search(String text) async {
    if (isSearchMapContainsOnTrue) {
      await searchInSearchList(text);
    } else {
      await searchOnExpensesIncomesList(text);
    }
  }
}
