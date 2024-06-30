
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_states.dart';

import '../../../categories/data/models/categories_model.dart';
import '../../data/models/reports_model.dart';

class ReportsCubit extends Cubit<ReportsStates> {
  ReportsCubit() : super(InitialReportsState());

  bool isExpeses = true;

  List<List<ExpensesIncomeModel>> allExpenses = [];
  List<List<ExpensesIncomeModel>> allIncomes = [];
  List<CategoryModel> expensesCategories = [];
  List<CategoryModel> incomesCategories = [];
  List<ExpensesIncomeModel> allExpensesIncomes = [];
  List<ReportsCategoryModel> reportExpensesCategories = [];
  List<ReportsCategoryModel> reportIncomesCategories = [];

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

  Future<List<ReportsCategoryModel>> filterToLastWeek(
      List<ReportsCategoryModel> expensesIncomes) async {
    if (expensesIncomes.isEmpty) return [];
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 7));
    expensesIncomes = expensesIncomes.where((e) {
      var date = DateTime.parse(e.dateTime!);
      return now_1w.isBefore(date);
    }).toList();
    return expensesIncomes;
  }

  Future<List<ReportsCategoryModel>> filterToLastMonth(
      List<ReportsCategoryModel> expensesIncomes) async {
    if (expensesIncomes.isEmpty) return [];
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 30));
    expensesIncomes = expensesIncomes.where((e) {
      var date = DateTime.parse(e.dateTime!);
      return now_1w.isBefore(date);
    }).toList();
    return expensesIncomes;
  }

  Future<void> filterExpensesToLastmonth() async {
    reportExpensesCategories =
        await filterToLastMonth(reportExpensesCategories);
    emit(FilterExpensesToLastMonth());
  }

  Future<void> filterExpensesToLastWeek() async {
    reportExpensesCategories = await filterToLastWeek(reportExpensesCategories);
    emit(FilterExpensesToLastWeek());
  }

  Future<void> filterIncomesToLastMonth() async {
    reportIncomesCategories = await filterToLastMonth(reportIncomesCategories);
    emit(FilterIncomesToLastMonth());
  }

  Future<void> filterIncomesToLastWeek() async {
    reportIncomesCategories = await filterToLastWeek(reportIncomesCategories);
    emit(FilterIncomesToLastWeek());
  }

  Future<void> filtersIncomesToNameAndAmountOnly() async {
    reportIncomesCategories.clear();
    reportExpensesCategories.clear();
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
