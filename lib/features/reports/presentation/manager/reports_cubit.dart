import 'package:easy_localization/easy_localization.dart';
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

    for (var e in allExpenses) {
      var reports = ReportsCategoryModel();
      for (var j in e) {
        reports =
            reports.copyWith(amount: (reports.amount ?? 0 + j.amount!).toInt());
        reports = reports.copyWith(name: j.category!.name);
        reports = reports.copyWith(dateTime: j.dateTime);
      }

      reportExpensesCategories.add(reports);
    }
  }

  Future<void> filterExpensesToLastSevenDays() async {
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 7));
    reportExpensesCategories = reportExpensesCategories.where((e) {
      var date = DateTime.parse(e.dateTime!);
      return now_1w.isBefore(date);
    }).toList();
  }

//   import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MyObject {
//   DateTime createdAt;

//   MyObject({required this.createdAt});
// }

// void main() {
//   List<MyObject> objectsList = []; // Assuming your list of objects

//   DateTime now = DateTime.now();
//   DateTime sevenDaysAgo = now.subtract(Duration(days: 7));

//   List<MyObject> filteredObjects = objectsList.where((obj) {
//     return obj.createdAt.isAfter(sevenDaysAgo);
//   }).toList();

//   print(filteredObjects);
// }

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
      result.add(expenses);
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
