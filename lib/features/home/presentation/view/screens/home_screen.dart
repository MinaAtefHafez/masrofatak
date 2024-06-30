import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_cubit.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_statesd.dart';
import 'package:masrofatak/features/expenses_income/presentation/view/screens/add_expenses_income_screen.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';

import '../../../../categories/presentation/manager/category_cubit.dart';
import '../../../../reports/presentation/manager/reports_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const name = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeCubit = getIt<HomeCubit>();
  final categoryCubit = getIt<CategoryCubit>();
  final expensesIncomesCubit = getIt<ExpensesIncomeCubit>();
  final reportsCubit = getIt<ReportsCubit>();
  @override
  void initState() {
    super.initState();
    call();
  }

  void call() async {
    await categoryCubit.saveExpensesCategoriesLocal();
    await categoryCubit.getExpensesCategoriesLocal();
    await categoryCubit.saveIncomesCategoriesLocal();
    await categoryCubit.getIncomesCategoriesLocal();
    await expensesIncomesCubit.getExpensesIncomesLocal();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpensesIncomeCubit, ExpensesIncomeState>(
      bloc: expensesIncomesCubit,
      listener: (context, state) async {
        if (state is GetExpensesIncomesLocal) {
          await homeCubit.showExpensesIncomes(
              state.expensesIncomes, IntlHelper.monthNow);
          await reportsCubit.getAllExpensesIncomes(state.expensesIncomes);
          await reportsCubit.getExpenses();
          await reportsCubit.getIncomes();
          await reportsCubit.filtersExpensesToNameAndAmountOnly();
          await reportsCubit.filtersIncomesToNameAndAmountOnly();
          await reportsCubit.filterExpensesToLastWeek();
        }
      },
      child: BlocListener<CategoryCubit, CategoryState>(
        bloc: categoryCubit,
        listener: (context, state) {
          if (state is GeExpensesCategoriesLocal) {
            reportsCubit.getExpensesCategories(state.categories);
          }

          if (state is GetIncomesCategoriesLocal) {
            reportsCubit.getIncomesCategories(state.categories);
          }
        },
        child: BlocBuilder<HomeCubit, HomeStates>(
          bloc: homeCubit,
          builder: (context, state) {
            return Scaffold(
              body: homeCubit.homeScreens[homeCubit.bottomNavIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: homeCubit.bottomNavIndex,
                onTap: homeCubit.changeBottomNavIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(homeCubit.bottomNavIndex == 0
                          ? Assets.imagesReportBlack
                          : Assets.imagesReportGrey),
                      label: tr('Report')),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(homeCubit.bottomNavIndex == 1
                          ? Assets.imagesHomeBlack
                          : Assets.imagesHomeGrey),
                      label: tr('Home')),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(homeCubit.bottomNavIndex == 2
                          ? Assets.imagesSettingsBlack
                          : Assets.imagesSettingsGrey),
                      label: tr('Settings')),
                ],
              ),
              floatingActionButton: homeCubit.bottomNavIndex == 1
                  ? FloatingActionButton(
                      onPressed: () {
                        CustomNavigator.pushNamed(AddExpensesIncomeScreen.name);
                      },
                      child: const Icon(Icons.add),
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
