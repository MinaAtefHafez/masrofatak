import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_states.dart';

import '../../../categories/data/models/categories_model.dart';

class ReportsCubit extends Cubit<ReportsStates> {
  ReportsCubit() : super(InitialReportsState());

  List<List<dynamic>> allExpenses = [];
  List<List<dynamic>> allIncomes = [];
  List<CategoryModel> expensesCategories = [];
  List<CategoryModel> incomesCategories = [];
  List<dynamic> allExpensesIncomes = [];
  Future<void> getExpensesCategories(List<CategoryModel> list) async {
    expensesCategories = List.from(list);
  }

  Future<void> getIncomesCategories(List<CategoryModel> list) async {
    incomesCategories = List.from(list);
  }

  Future<void> getAllExpensesIncomes(List<dynamic> list) async {
    allExpensesIncomes = List.from(list);
  }

  Future<List<List<dynamic>>> getExpesesImpl() async {
    allExpenses.clear();
    List<dynamic> expenses = [];
    List<List<dynamic>> result = [];
    for (var e in expensesCategories) {
      expenses.clear();
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
    allExpenses = await getExpesesImpl();
  }

  Future<void> getIncomes() async {
    allIncomes = await getIncomesImpl();
  }

  Future<List<List<dynamic>>> getIncomesImpl() async {
    allIncomes.clear();
    List<dynamic> incomes = [];
    List<List<dynamic>> result = [];
    for (var e in incomesCategories) {
      incomes.clear();
      for (var j in allExpensesIncomes) {
        if (e.name == j.category!.name && j.type == 'Income') {
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
