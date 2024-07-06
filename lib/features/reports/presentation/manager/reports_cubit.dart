import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_states.dart';

import '../../../categories/data/models/categories_model.dart';
import '../../data/models/reports_model.dart';
import '../../../../core/filters/filters.dart';

class ReportsCubit extends Cubit<ReportsStates> {
  ReportsCubit() : super(InitialReportsState());

  int filterDaysDropIndex = 3;
  int filterIncomesIndex = 0;

  List<CategoryModel> expensesCategories = [];
  List<CategoryModel> incomesCategories = [];
  List<ExpensesIncomeModel> allExpensesIncomes = [];
  List<ReportsCategoryModel> reportExpensesCategories = [];
  List<ReportsCategoryModel> reportIncomesCategories = [];

  List<ReportsCategoryModel> get reportsCategories => filterIncomesIndex == 0
      ? reportExpensesCategories
      : reportIncomesCategories;

  Future<void> changeDaysDropIndex(int index) async {
    filterDaysDropIndex = index;
    emit(ChangeFilterDropIndex());
  }

  Future<void> changeIncomesDropIndex(int index) async {
    filterIncomesIndex = index;
    emit(ChangeFilterDropIndex());
  }

  Future<void> filter() async {
    if (filterIncomesIndex == 0) {
      await filterExpenses();
    } else {
      await filterIncomes();
    }
    emit(FilterState());
  }

  Future<List<ReportsCategoryModel>> sumAmountsOfCategory(
      List<ReportsCategoryModel> reports) async {
    List<ReportsCategoryModel> list = [];
    for (int i = 0; i < reports.length; i++) {
      var item = reports[i];
      var nameCompare = reports[i].name;
      for (int j = 0; j < reports.length; j++) {
        if (j == i) continue;
        var name = reports[j].name;
        if (name == nameCompare) {
          item = item.copyWith(amount: (item.amount! + reports[j].amount!));
        }
      }

      list.add(item);
    }
    return list;
  }

  Future<void> sumAmountsOfExpensesCategory() async {
    reportExpensesCategories =
        await sumAmountsOfCategory(reportExpensesCategories);
  }

  Future<void> sumAmountsOfIncomeCategory() async {
    reportIncomesCategories =
        await sumAmountsOfCategory(reportIncomesCategories);
  }

  Future<void> handleSumsAmounts() async {
    if (filterIncomesIndex == 0) {
      await sumAmountsOfExpensesCategory();
    } else {
      await sumAmountsOfIncomeCategory();
    }
    emit(HandleSumsAmounts());
  }

  Future<void> filterExpenses() async {
    await filterToAll();
    var filter = FilterFactory.getFilter(filterDaysDropIndex);
    reportExpensesCategories = await filter.filter(reportExpensesCategories);
    await handleSumsAmounts();
  }

  Future<void> filterIncomes() async {
    await filterToAll();
    var filter = FilterFactory.getFilter(filterDaysDropIndex);
    reportIncomesCategories = await filter.filter(reportIncomesCategories);
    await handleSumsAmounts();
  }

  Future<void> filterToAll() async {
    if (filterIncomesIndex == 0) {
      reportExpensesCategories =
          await convertExpensesOrIncomesToReportsCategories('Expenses');
    } else {
      reportIncomesCategories =
          await convertExpensesOrIncomesToReportsCategories('Incomes');
    }

    emit(GetAllFilters());
  }

  Future<List<ReportsCategoryModel>>
      convertExpensesOrIncomesToReportsCategories(String type) async {
    var data = allExpensesIncomes.where((e) => e.type == type).toList();
    return data
        .map((e) => ReportsCategoryModel(
              amount: e.amount,
              dateTime: e.dateTime,
              name: e.category!.name,
            ))
        .toList();
  }

  Future<void> getExpensesCategoriesFromCategoryCubit(
      List<dynamic> list) async {
    expensesCategories = List.from(list);
  }

  Future<void> getIncomesCategoriesFromCategoryCubit(
      List<dynamic> list) async {
    incomesCategories = List.from(list);
  }

  Future<void> getAllExpensesIncomesFromCategoryCubit(
      List<dynamic> list) async {
    allExpensesIncomes = List.from(list);
  }

}
