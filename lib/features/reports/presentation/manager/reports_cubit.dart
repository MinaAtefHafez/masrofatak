import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/expenses_income/data/models/expenses_income_model.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_states.dart';

import '../../../categories/data/models/categories_model.dart';
import '../../data/models/reports_model.dart';

class ReportsCubit extends Cubit<ReportsStates> {
  ReportsCubit() : super(InitialReportsState());

  List<List<ExpensesIncomeModel>> allExpenses = [];
  List<List<ExpensesIncomeModel>> allIncomes = [];
  List<CategoryModel> expensesCategories = [];
  List<CategoryModel> incomesCategories = [];
  List<ExpensesIncomeModel> allExpensesIncomes = [];
  List<ReportsCategoryModel> reportExpensesCategories = [];
  List<ReportsCategoryModel> reportIncomesCategories = [];

  Future<void> filtersExpensesToNameAndAmountOnly() async {
    reportExpensesCategories.clear();
    int sum = 0;

    for (var e in allExpenses) {
      String? name;
      String? dateTime;
      sum = 0;

      for (var j in e) {
        sum = (sum + j.amount!).toInt();
        name = j.category!.name;
        dateTime = j.dateTime;
      }
      reportExpensesCategories.add(
          ReportsCategoryModel(name: name, amount: sum, dateTime: dateTime));
    }
  }

  Future<void> filterExpensesToLastWeek() async {
    if (reportExpensesCategories.isEmpty) return;
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 7));
    reportExpensesCategories = reportExpensesCategories.where((e) {
      log(reportExpensesCategories.length.toString());
      var date = DateTime.parse(e.dateTime!);
      return now_1w.isBefore(date);
    }).toList();
  }

  Future<void> filtersIncomesToNameAndAmountOnly() async {
    reportIncomesCategories.clear();
    int sum = 0;

    for (var e in allIncomes) {
      String? name;
      sum = 0;

      for (var j in e) {
        sum = (sum + j.amount!).toInt();
        name = j.category!.name;
      }
      reportIncomesCategories
          .add(ReportsCategoryModel(name: name, amount: sum));
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
      if ( expenses.isNotEmpty) {
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
