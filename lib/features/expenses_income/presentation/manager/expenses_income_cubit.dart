import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/features/categories/data/models/categories_model.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_statesd.dart';

import '../../data/models/expenses_income_model.dart';

class ExpensesIncomeCubit extends Cubit<ExpensesIncomeState> {
  ExpensesIncomeCubit() : super(InitialState());

  ExpensesIncomeModel expensesIncomeModel = ExpensesIncomeModel();

  bool isExpense = true;

  void onAmountChanged(String amount) {
    expensesIncomeModel =
        expensesIncomeModel.copyWith(amount: double.parse(amount));
  }

  void chooseCategory(CategoryModel category) {
    expensesIncomeModel = expensesIncomeModel.copyWith(category: category);
  }

  void onDescriptionChanged(String description) {
    expensesIncomeModel =
        expensesIncomeModel.copyWith(description: description);
  }

  void onChooseIncome() {
    isExpense = false;
    onTypeIncomeChanged();
  }

  void onChooseExpenses() {
    isExpense = true;
    onTypeIncomeChanged();
  }

  void onTypeIncomeChanged() {
    if (isExpense) {
      expensesIncomeModel = expensesIncomeModel.copyWith(type: 'Expenses');
    } else {
      expensesIncomeModel = expensesIncomeModel.copyWith(type: 'Income');
    }
    emit(OnTypeIncomeChanged());
  }
}
