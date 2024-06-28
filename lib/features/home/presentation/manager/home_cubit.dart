import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';
import 'package:masrofatak/features/home/presentation/view/screens/home_details_screen.dart';
import 'package:masrofatak/features/settings/presentation/view/screens/settings_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  int bottomNavIndex = 1;

  List<dynamic> expensesIncomes = [];
  List<dynamic> expensesIncomesAfterFilterAccordingMonth = [];
  List<List<dynamic>> expensesIncomesDays = [];

  List<dynamic> get filtersList => expensesIncomesAfterFilterAccordingMonth;

  List<List<dynamic>> get allExpensesIncomes => expensesIncomesDays ;

  void changeBottomNavIndex(int index) {
    bottomNavIndex = index;
    emit(ChangeBottomNavBar());
  }

  final homeScreens = [
    const HomeDetailsScreen(),
    const HomeDetailsScreen(),
    const SettingsScreen(),
  ];

  Future<void> getExpensesIncomes(List<dynamic> expensesIncomesList) async {
    await getExpensesIncomesFromExpensesCubit(expensesIncomesList);
    await filterExpensesIncomesAccordingMonthDate(IntlHelper.monthNow);
    await sortingExppensesIncomesAccordingDay();
    await getExpensesIncomesForEachDay();
  }

  Future<void> getExpensesIncomesFromExpensesCubit(
      List<dynamic> expensesIncomesList) async {
    expensesIncomes = List.from(expensesIncomesList);
    emit(GetAllExpensesIncomes());
  }

  Future<void> filterExpensesIncomesAccordingMonthDate(String month) async {
    expensesIncomesAfterFilterAccordingMonth =
        expensesIncomes.where((element) => element.month == month).toList();
    emit(FilterExpensesIncomesAccordingMonthDate());
  }

  Future<void> sortingExppensesIncomesAccordingDay() async {
    expensesIncomesAfterFilterAccordingMonth
        .sort((a, b) => int.parse(b.day).compareTo(int.parse(a.day)));
    emit(SortingExpensesIncomesAccordingDay());
  }

  Future <void> getExpensesIncomesForEachDay () async {
     expensesIncomesDays = await getExpensesIncomesForEachDayImpl();
     emit(GetExpensesIncomesForEachDay());
  }

  Future<List<List<dynamic>>> getExpensesIncomesForEachDayImpl() async {
    List<List<dynamic>> days = [];
    for (int i = 1; i <= 31; i++) {
      List<dynamic> day = [];
      for (int j = 0; j < filtersList.length; j++) {
        if (int.parse(filtersList[j].day) == i) {
          day.add(filtersList[j]);
        }
      }
      if (day.isNotEmpty) {
        days.add(day);
      }
    }
    return days;
  }
}
