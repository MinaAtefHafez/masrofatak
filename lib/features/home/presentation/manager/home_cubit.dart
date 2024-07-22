
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/features/home/data/models/all_money_model.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/reports/presentation/screens/reports_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';
import '../../../expenses_income/data/models/expenses_income_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  int bottomNavIndex = 1;

  int monthAsInt = int.parse(IntlHelper.monthNow);
  String monthName = IntlHelper.month();
  int yearAsInt = int.parse(IntlHelper.yearNow);

  List<ExpensesIncomeModel> expensesIncomes = [];
  List<ExpensesIncomeModel> expensesIncomesForYear = [];
  List<ExpensesIncomeModel> expensesIncomesForMonth = [];

  List<List<ExpensesIncomeModel>> expensesIncomesEachDay = [];
  List<int> sumsExpensesIncomesPerMonth = [];
  List<ExpensesIncomeModel> expensesIncomesPerDay = [];
  List<ExpensesIncomeModel> today = [];
  int sumAmountToday = 0;
  AllMoneyModel allMoney = AllMoneyModel(balance: 0, expenses: 0, incomes: 0);

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavBar());
  }

  final homeScreens = [
    const ReportsScreen(),
    const HomeDetailsScreen(),
    const SettingsScreen(),
  ];

  Future<void> showExpensesIncomes() async {
    await filterExpensesIncomesForYear();
    await filterExpensesIncomesForMonth();
    await getAllExpenses();
    await getAllIncomes();
    await getBalance();
    await sortingExppensesIncomesAccordingDay();
    await getExpensesIncomesForEachDay();
    await getSumForMonth();
    await getToday();
    await getSumAountToday();
  }

  Future<void> changeToPreviousMonth() async {
    if (monthAsInt == 1) return;
    monthAsInt = monthAsInt - 1;
    monthName = IntlHelper.month(monthAsInt);
  }

  Future<void> changeToNextMonth() async {
    if (monthAsInt == 12) return;
    monthAsInt = monthAsInt + 1;
    monthName = IntlHelper.month(monthAsInt);
  }

  Future<void> changeToPreviousYear() async {
    yearAsInt = yearAsInt - 1;
    monthAsInt = 12;
    monthName = IntlHelper.month(monthAsInt);
  }

  Future<void> changeToNextYear() async {
    yearAsInt = yearAsInt + 1;
    monthAsInt = 1;
    monthName = IntlHelper.month(monthAsInt);
  }

  Future<void> changeToPreviousMonthOrYear() async {
    if (monthAsInt == 1) {
      changeToPreviousYear();
    } else {
      changeToPreviousMonth();
    }
  }

  Future<void> changeToNextMonthOrYear() async {
    if (monthAsInt == 12) {
      changeToNextYear();
    } else {
      changeToNextMonth();
    }
  }

  Future<int> getAllExpensesImpl(String type) async {
    int sum = 0;
    for (var e in expensesIncomesForMonth) {
      if (e.type == type) {
        sum = (sum + e.amount!).toInt();
      }
    }
    return sum;
  }

  Future<void> getAllIncomes() async {
    var incomesSumAmount = await getAllExpensesImpl('Incomes');
    allMoney = allMoney.copyWith(incomes: incomesSumAmount);
    emit(GetAllIncomes());
  }

  Future<void> getAllExpenses() async {
    var expensesSumAmount = await getAllExpensesImpl('Expenses');
    allMoney = allMoney.copyWith(expenses: expensesSumAmount);
    emit(GetAllExpenses());
  }

  Future<void> getBalance() async {
    allMoney =
        allMoney.copyWith(balance: allMoney.incomes! - allMoney.expenses!);
    emit(GetBalance());
  }

  Future<void> sortDaysExpensesIncomsAccordingNewest() async {
    expensesIncomesPerDay.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));
    expensesIncomesPerDay = expensesIncomesPerDay.reversed.toList();
    emit(SortingExpensesIncomesForDay());
  }

  Future<void> sortDaysExpensesIncomsAccordingOldest() async {
    expensesIncomesPerDay.sort((a, b) => a.dateTime!.compareTo(b.dateTime!));

    emit(SortingExpensesIncomesForDay());
  }

  Future<void> sortDaysExpensesIncomsAccordingMostExpensive() async {
    expensesIncomesPerDay.sort((a, b) => a.amount!.compareTo(b.amount!));
    expensesIncomesPerDay = expensesIncomesPerDay.reversed.toList();
    emit(SortingExpensesIncomesForDay());
  }

  Future<void> sortDaysExpensesIncomsAccordingLowExpensive() async {
    expensesIncomesPerDay.sort((a, b) => a.amount!.compareTo(b.amount!));

    emit(SortingExpensesIncomesForDay());
  }

  Future<void> getExpensesIncomesPerDay(List<dynamic> item) async {
    expensesIncomesPerDay = List.from(item);
    emit(GetExpensesIncomesPerDay());
  }

  Future<List<ExpensesIncomeModel>> getDayFromDaysList(
      {required List<List<ExpensesIncomeModel>> days,
      required String day}) async {
    List<ExpensesIncomeModel> result = [];
    for (var e in days) {
      if (e[0].day == day) {
        result = List.from(e);
        break;
      }
    }
    return result;
  }

  Future<void> getToday() async {
    today = await getDayFromDaysList(
        days: expensesIncomesEachDay, day: IntlHelper.dayNow);
    emit(GetToday());
  }

  Future<int> getSumAmountPerDay(List<dynamic> data) async {
    int sum = 0;
    List<int> amounts = [];
    for (var e in data) {
      amounts.add(e.amount);
    }

    for (var e in amounts) {
      sum = sum + e;
    }

    return sum;
  }

  Future<void> getSumAountToday() async {
    sumAmountToday = await getSumAmountPerDay(today);
    emit(GetSumToday());
  }

  Future<List<int>> getSumForMonthImpl(List<List<dynamic>> list) async {
    List<int> amounts = [];
    for (var e in list) {
      var sum = await getSumAmountPerDay(e);

      amounts.add(sum);
    }
    return amounts;
  }

  Future<void> getSumForMonth() async {
    sumsExpensesIncomesPerMonth =
        await getSumForMonthImpl(expensesIncomesEachDay);
    emit(GetSumMonthNow());
  }

  Future<void> getExpensesIncomesFromExpensesCubit(
      List<dynamic> expensesIncomesList) async {
    expensesIncomes = List.from(expensesIncomesList);
    emit(GetAllExpensesIncomes());
  }

  Future<void> filterExpensesIncomesForMonth() async {
    expensesIncomesForMonth = expensesIncomesForYear
        .where((element) => element.month == monthAsInt.toString())
        .toList();

    emit(FilterExpensesIncomesAccordingMonthDate());
  }

  Future<void> filterExpensesIncomesForYear() async {
    expensesIncomesForYear = expensesIncomes
        .where((element) => element.year.toString() == yearAsInt.toString())
        .toList();
  }

  Future<void> sortingExppensesIncomesAccordingDay() async {
    expensesIncomesForMonth
        .sort((a, b) => int.parse(b.day!).compareTo(int.parse(a.day!)));
    emit(SortingExpensesIncomesAccordingDay());
  }

  Future<void> getExpensesIncomesForEachDay() async {
    expensesIncomesEachDay = await getExpensesIncomesForEachDayImpl();
    emit(GetExpensesIncomesForEachDay());
  }

  Future<List<List<ExpensesIncomeModel>>>
      getExpensesIncomesForEachDayImpl() async {
    List<List<ExpensesIncomeModel>> days = [];
    for (int i = 1; i <= 31; i++) {
      List<ExpensesIncomeModel> day = [];
      for (int j = 0; j < expensesIncomesForMonth.length; j++) {
        if (int.parse(expensesIncomesForMonth[j].day!) == i) {
          day.add(expensesIncomesForMonth[j]);
        }
      }
      if (day.isNotEmpty) {
        days.add(day);
      }
    }
    return days;
  }
}
