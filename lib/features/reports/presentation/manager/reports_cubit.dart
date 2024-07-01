import 'dart:developer';

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

  List<List<ExpensesIncomeModel>> allExpenses = [];
  List<List<ExpensesIncomeModel>> allIncomes = [];
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
      var sum = 0;
      var item = reports[i];
      var nameCompare = reports[i].name;
      for (int j = 0; j < reports.length; j++) {
        if (j == i) continue;
        var name = reports[j].name;
        if (name == nameCompare) {
          sum = sum + reports[j].amount! ;
          item = item.copyWith(amount: sum);
        }
      }

      list.add(item);
    }
    return list;
  }

  Future<void> sumAmountsOfExpensesCategory() async {
    reportExpensesCategories =
        await sumAmountsOfCategory(reportExpensesCategories);
    emit(SumAmountsOfCategory());
  }

  Future<void> sumAmountsOfIncomeCategory() async {
    reportIncomesCategories =
        await sumAmountsOfCategory(reportIncomesCategories);
    emit(SumAmountsOfCategory());
  }

  Future<void> handleSumsAmounts() async {
    if (filterIncomesIndex == 0) {
      await sumAmountsOfExpensesCategory();
    } else {
      await sumAmountsOfIncomeCategory();
    }
  }

  Future<void> filterExpenses() async {
    var filter = FilterFactory.getFilter(filterDaysDropIndex);
    reportExpensesCategories = await filter.filter(reportExpensesCategories);
    await handleSumsAmounts();
  }

  Future<void> filterIncomes() async {
    var filter = FilterFactory.getFilter(filterDaysDropIndex);
    reportIncomesCategories = await filter.filter(reportIncomesCategories);
    await handleSumsAmounts();
  }

  Future<void> getAllFilters() async {
    if (filterIncomesIndex == 0) {
      await convertExpensesToReportsCategories();
    } else {
      await convertIncomesToReportsCategories();
    }

    emit(GetAllFilters());
  }

  Future<void> convertExpensesToReportsCategories() async {
    reportExpensesCategories.clear();
    for (var e in allExpenses) {
      for (var j in e) {
        ReportsCategoryModel model = ReportsCategoryModel(
          amount: j.amount,
          dateTime: j.dateTime,
          name: j.category!.name,
        );
        reportExpensesCategories.add(model);
      }
    }
  }

  Future<void> convertIncomesToReportsCategories() async {
    reportIncomesCategories.clear();
    for (var e in allIncomes) {
      for (var j in e) {
        ReportsCategoryModel model = ReportsCategoryModel(
          amount: j.amount,
          dateTime: j.dateTime,
          name: j.category!.name,
        );
        reportExpensesCategories.add(model);
      }
    }
  }

  Future<void> getExpensesCategories(List<CategoryModel> list) async {
    expensesCategories = List.from(list);
  }

  Future<void> getIncomesCategories(List<CategoryModel> list) async {
    incomesCategories = List.from(list);
  }

  Future<void> getAllExpensesIncomes(List<dynamic> list) async {
    allExpensesIncomes = List.from(list);
  }

  Future<List<List<ExpensesIncomeModel>>> getExpesesImpl() async {
    List<ExpensesIncomeModel> expenses = [];
    List<List<ExpensesIncomeModel>> result = [];
    for (var e in expensesCategories) {
      expenses = [];
      for (var j in allExpensesIncomes) {
        if (e.name == j.category!.name && j.type == 'Expenses') {
          expenses.add(j);
        }
      }
      if (expenses.isNotEmpty) {
        result.add(expenses);
      }
    }

    return result;
  }

  Future<void> getExpenses() async {
    allExpenses.clear();
    allExpenses = await getExpesesImpl();
  }

  Future<void> getIncomes() async {
    allIncomes.clear();
    allIncomes = await getIncomesImpl();
  }

  Future<List<List<ExpensesIncomeModel>>> getIncomesImpl() async {
    List<ExpensesIncomeModel> incomes = [];
    List<List<ExpensesIncomeModel>> result = [];
    for (var e in incomesCategories) {
      incomes = [];
      for (var j in allExpensesIncomes) {
        if (e.name == j.category!.name && j.type == 'Incomes') {
          incomes.add(j);
        }
      }
      if (incomes.isNotEmpty) {
        result.add(incomes);
      }
    }
    return result;
  }
}
