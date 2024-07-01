import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_states.dart';
import 'package:masrofatak/features/home/presentation/view/screens/day_details_screen.dart';
import 'package:masrofatak/features/home/presentation/view/widgets/expenses_incomes_item.dart';

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
            HomeDetailsTopPart(onTap: () {}),
            SizedBox(height: 16.h),
            DateMonthPickerItem(
                onTap: () {}, onTapLeft: () {}, onTapRight: () {}),
            SizedBox(height: 30.h),
            BlocBuilder<HomeCubit, HomeStates>(
              bloc: homeCubit,
              builder: (context, state) {
                return HomeBasicItem(allMoney: homeCubit.getAllMoney);
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: BlocBuilder<HomeCubit, HomeStates>(
                  bloc: homeCubit,
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (homeCubit.todayy != null &&
                            homeCubit.todayy!.isNotEmpty) ...[
                          ExpensesIncomesItem(
                            onTap: () async {
                              await homeCubit
                                  .getExpensesIncomesPerDay(homeCubit.today);
                              CustomNavigator.pushNamed(DayDetailsScreen.name);
                            },
                            today: 'today',
                            expensesIncomesModel: homeCubit.todayy!,
                            amountPerDay: homeCubit.sumToday,
                          ),
                        ],
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                ExpensesIncomesItem(
                                  onTap: () async {
                                    await homeCubit.getExpensesIncomesPerDay(
                                        homeCubit
                                            .expensesIncomesEachDay[index]);
                                    CustomNavigator.pushNamed(
                                        DayDetailsScreen.name);
                                  },
                                  expensesIncomesModel:
                                      homeCubit.allExpensesIncomes[index],
                                  amountPerDay: homeCubit
                                      .sumsExpensesIncomesPerMonth[index],
                                ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16.h),
                            itemCount: homeCubit.allExpensesIncomes.length),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
