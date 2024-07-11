import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/helpers/intl_helper/intl_helper.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';
import 'package:masrofatak/features/home/presentation/view/screens/day_details_screen.dart';
import 'package:masrofatak/features/home/presentation/view/widgets/expenses_incomes_item.dart';
import 'package:masrofatak/features/search/presentation/view/screens/search_screen.dart';

import '../widgets/home_basic_item.dart';
import '../widgets/home_date_month_picker.dart';
import '../widgets/home_details_top_part.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  static const name = '/homeDetails';

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  final homeCubit = getIt<HomeCubit>();
  final expensesIncomesCubit = getIt<ExpensesIncomeCubit>();
  final categoryCubit = getIt<CategoryCubit>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            HomeDetailsTopPart(onTap: () {
              CustomNavigator.pushNamed(SearchScreen.name);
            }),
            SizedBox(height: 30.h),
            BlocBuilder<HomeCubit, HomeStates>(
              bloc: homeCubit,
              builder: (context, state) {
                return Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: DateMonthPickerItem(
                            month: homeCubit.monthName,
                            onTap: () {},
                            onTapLeft: () async {
                              await homeCubit.changeToPreviousMonth();
                              await homeCubit.showExpensesIncomes();
                            },
                            onTapRight: () async {
                              await homeCubit.changeToNextMonth();
                              await homeCubit.showExpensesIncomes();
                            }),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 30.h),
                      ),
                      SliverToBoxAdapter(
                        child: HomeBasicItem(allMoney: homeCubit.getAllMoney),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 16),
                      ),
                      if (homeCubit.monthName == IntlHelper.month())
                        SliverToBoxAdapter(
                          child: ExpensesIncomesItem(
                            onTap: () async {
                              await homeCubit
                                  .getExpensesIncomesPerDay(homeCubit.today);
                              CustomNavigator.pushNamed(DayDetailsScreen.name);
                            },
                            today: 'today',
                            expensesIncomesModel: homeCubit.todayy!,
                            amountPerDay: homeCubit.sumToday,
                          ),
                        ),
                      SliverToBoxAdapter(
                        child: SizedBox(height: 25.h),
                      ),
                      SliverList.separated(
                          itemBuilder: (context, index) => ExpensesIncomesItem(
                                onTap: () async {
                                  await homeCubit.getExpensesIncomesPerDay(
                                      homeCubit.expensesIncomesEachDay[index]);
                                  CustomNavigator.pushNamed(
                                      DayDetailsScreen.name,
                                      arguments: homeCubit
                                          .expensesIncomesEachDay[index]);
                                },
                                expensesIncomesModel:
                                    homeCubit.allExpensesIncomes[index],
                                amountPerDay: homeCubit
                                    .sumsExpensesIncomesPerMonth[index],
                              ),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 25.h),
                          itemCount: homeCubit.allExpensesIncomes.length)
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
