import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  int bottomNavIndex = 1;

  List<dynamic> expensesIncomes = [];
  List<dynamic> expensesIncomesForMonth = [];
  List<List<dynamic>> expensesIncomesEachDay = [];
  List<int> sumsExpensesIncomesPerMonth = [];
  List<dynamic> expensesIncomesPerDay = [];
  dynamic today;
  int sumAmountToday = 0;

  List<dynamic> get expensesIncomesMonth => expensesIncomesForMonth;

  List<List<dynamic>> get allExpensesIncomes => expensesIncomesEachDay;

  List<dynamic>? get todayy => today;

  int get sumToday => sumAmountToday;

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavBar());
  }

  final homeScreens = [
    const HomeDetailsScreen(),
    const HomeDetailsScreen(),
    const SettingsScreen(),
  ];

  Future<void> showExpensesIncomes(
      List<dynamic> expensesIncomesList, String month) async {
    await getExpensesIncomesFromExpensesCubit(expensesIncomesList);
    await filterExpensesIncomesForMonth(month);
    await sortingExppensesIncomesAccordingDay();
    await getExpensesIncomesForEachDay();
    await getSumForMonthImpl();
    await getToday();
    await getSumAmountToday();
  }

  Future<void> getExpensesIncomesPerDay(int index) async {
    expensesIncomesPerDay = List.from(expensesIncomesEachDay[index]);
    emit(GetExpensesIncomesPerDay());
  }

  Future<void> getToday() async {
    for (var e in expensesIncomesEachDay) {
      if (e[0].day == IntlHelper.dayNow) {
        today = e;
        break;
      }
    }
    emit(GetToday());
  }

  Future<void> getSumAmountToday() async {
    if (today == null) {
      return;
    }
    int sum = 0;
    for (var e in today) {
      if (e.type == 'Expenses') {
        sum = (sum + e.amount).toInt() * -1;
      } else {
        sum = (sum + e.amount).toInt();
      }
    }
    sumAmountToday = sum;
    emit(GetSumToday());
  }

  Future<List<int>> getSumForMonth(List<List<dynamic>> list) async {
    List<int> amounts = [];
    int sum = 0;
    for (var e in list) {
      sum = 0;
      for (var j in e) {
        if (j.type == 'Expenses') {
          sum = (sum + j.amount).toInt() * -1;
        } else {
          sum = (sum + j.amount).toInt();
        }
      }
      amounts.add(sum);
    }
    return amounts;
  }

  Future<void> getSumForMonthImpl() async {
    sumsExpensesIncomesPerMonth = await getSumForMonth(expensesIncomesEachDay);
    emit(GetSumMonthNow());
  }

  Future<void> getExpensesIncomesFromExpensesCubit(
      List<dynamic> expensesIncomesList) async {
    expensesIncomes = List.from(expensesIncomesList);
    emit(GetAllExpensesIncomes());
  }

  Future<void> filterExpensesIncomesForMonth(String month) async {
    expensesIncomesForMonth =
        expensesIncomes.where((element) => element.month == month).toList();
    emit(FilterExpensesIncomesAccordingMonthDate());
  }

  Future<void> sortingExppensesIncomesAccordingDay() async {
    expensesIncomesForMonth
        .sort((a, b) => int.parse(b.day).compareTo(int.parse(a.day)));
    emit(SortingExpensesIncomesAccordingDay());
  }

  Future<void> getExpensesIncomesForEachDay() async {
    expensesIncomesEachDay = await getExpensesIncomesForEachDayImpl();
    emit(GetExpensesIncomesForEachDay());
  }

  Future<List<List<dynamic>>> getExpensesIncomesForEachDayImpl() async {
    List<List<dynamic>> days = [];
    for (int i = 1; i <= 31; i++) {
      List<dynamic> day = [];
      for (int j = 0; j < expensesIncomesMonth.length; j++) {
        if (int.parse(expensesIncomesMonth[j].day) == i) {
          day.add(expensesIncomesMonth[j]);
        }
      }
      if (day.isNotEmpty) {
        days.add(day);
      }
    }
    return days;
  }
}
