
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

  Future<void> changeFilterDaysDropIndex(int index) async {
    filterDaysDropIndex = index;
    emit(ChangeFilterDropIndex());
  }

  Future<void> changeFilterIncomesDropIndex(int index) async {
    filterIncomesIndex = index;
    emit(ChangeFilterDropIndex());
  }

  Future<void> filter() async {
    var filter = FilterFactory.getFilter(filterDaysDropIndex);
    if (filterIncomesIndex == 0) {
      reportExpensesCategories = await filter.filter(reportExpensesCategories);
    } else {
      reportIncomesCategories = await filter.filter(reportIncomesCategories);
    }
    emit(FilterState());
  }

  Future<void> getAllFilters() async {
    if (filterIncomesIndex == 0) {
      await filtersExpensesToNameAndAmountOnly();
    } else {
      await filtersIncomesToNameAndAmountOnly();
    }
    emit(GetAllFilters());
  }

  Future<void> filtersExpensesToNameAndAmountOnly() async {
    reportExpensesCategories.clear();
    for (var e in allExpenses) {
      ReportsCategoryModel model = ReportsCategoryModel();
      for (var j in e) {
        model = model.copyWith(amount: model.amount ?? 0 + j.amount!);
        model = model.copyWith(name: j.category!.name);
        model = model.copyWith(dateTime: j.dateTime);
      }
      if (model.dateTime != null) {
        reportExpensesCategories.add(model);
      }
    }
  }

  Future<void> filtersIncomesToNameAndAmountOnly() async {
    reportIncomesCategories.clear();
    for (var e in allIncomes) {
      ReportsCategoryModel model = ReportsCategoryModel();
      for (var j in e) {
        model = model.copyWith(amount: model.amount ?? 0 + j.amount!);
        model = model.copyWith(name: j.category!.name);
        model = model.copyWith(dateTime: j.dateTime);
      }
      if (model.dateTime != null) {
        reportIncomesCategories.add(model);
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
