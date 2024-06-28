import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/features/categories/data/models/categories_model.dart';
import 'package:masrofatak/features/expenses_income/data/repo/expenses_income_repo.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_statesd.dart';
import '../../data/models/expenses_income_model.dart';

class ExpensesIncomeCubit extends Cubit<ExpensesIncomeState> {
  ExpensesIncomeCubit(this._expensesIncomeRepo) : super(InitialState());

  final ExpensesIncomeRepo _expensesIncomeRepo;

  ExpensesIncomeModel expensesIncomeModel = ExpensesIncomeModel()
    ..type = 'Expenses'
    ..day = IntlHelper.dayNow
    ..month = IntlHelper.monthNow
    ..category =
        CategoryModel(id: 0, icon: Assets.imagesShopping, name: 'Grocery');

  bool isExpense = true;
  List<dynamic> expensesIncomeList = [];

  Future<void> addExpensesIncomeToList() async {
    expensesIncomeList.add(expensesIncomeModel);
  }

  Future<void> getExpensesIncomesLocal() async {
    var data = await _expensesIncomeRepo.getExpensesIncomeLocal();

    expensesIncomeList = data ?? [];
    emit(GetExpensesIncomesLocal(expensesIncomeList));
  }

  Future<void> saveExpensesIncomesLocal() async {
    await _expensesIncomeRepo.saveExpensesIncomeLocal(expensesIncomeList);

    emit(SaveExpensesIncomeLocal());
  }

  Future<void> addExpensesOrIncome() async {
    await addExpensesIncomeToList();
    await saveExpensesIncomesLocal();
    await getExpensesIncomesLocal();
  }

  void onAmountChanged(String amount) {
    expensesIncomeModel =
        expensesIncomeModel.copyWith(amount: int.parse(amount));
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
      expensesIncomeModel = expensesIncomeModel.copyWith(type: 'Incomes');
    }
    emit(OnTypeIncomeChanged());
  }
}
