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
    ..year = IntlHelper.yearNow
    ..dateTime = IntlHelper.dateTimeNow
    ..category =
        CategoryModel(id: 0, icon: Assets.imagesShopping, name: 'Shopping');

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

  void onDayChanged(String day) {
    expensesIncomeModel = expensesIncomeModel.copyWith(day: day);
    emit(OnModelChanged());
  }

  void onDateTimeChanged(String dateTime) {
    expensesIncomeModel = expensesIncomeModel.copyWith(dateTime: dateTime);
  }

  void onMonthChanged(String month) {
    expensesIncomeModel = expensesIncomeModel.copyWith(month: month);
    emit(OnModelChanged());
  }

  void onYearChanged(String year) {
    expensesIncomeModel = expensesIncomeModel.copyWith(year: year);
    emit(OnModelChanged());
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

  void onExpensesChanged() {
    expensesIncomeModel = expensesIncomeModel.copyWith(
        type: 'Expenses',
        category: CategoryModel(
            id: 0, icon: Assets.imagesShopping, name: 'Shopping'));
  }

  void onIncomesChanged() {
    expensesIncomeModel = expensesIncomeModel.copyWith(
        type: 'Incomes',
        category:
            CategoryModel(id: 0, icon: Assets.imagesSalary, name: 'Salary'));
  }

  void onTypeIncomeChanged() {
    if (isExpense) {
      onExpensesChanged();
    } else {
      onIncomesChanged();
    }
    emit(OnTypeIncomeChanged());
  }
}
