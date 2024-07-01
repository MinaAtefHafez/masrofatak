import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/features/reports/data/models/reports_model.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_cubit.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_states.dart';
import 'package:masrofatak/features/reports/presentation/widgets/reports_drop_down.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  static const name = '/reporsts';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final reportsCubit = getIt<ReportsCubit>();

  final filterItems = ['Today', 'LastWeek', 'LastMonth', 'All'];

  final incomeTypeItems = ['Expenses', 'Income'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportsCubit, ReportsStates>(
      bloc: reportsCubit,
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: EdgeInsets.only(top: 60.h),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                        child: ReportsDropDownButton(
                      onChanaged: (index) async {
                        await reportsCubit.changeFilterDaysDropIndex(index!);
                        if (index == 3) {
                          await reportsCubit.getAllFilters();
                          return;
                        }
                        await reportsCubit.filter();
                      },
                      items: filterItems,
                      value: reportsCubit.filterDaysDropIndex,
                    )),
                    SizedBox(width: 30.w),
                    Expanded(
                      child: ReportsDropDownButton(
                        onChanaged: (index) async {
                          await reportsCubit
                              .changeFilterIncomesDropIndex(index!);
                          await reportsCubit.filter();
                        },
                        value: reportsCubit.filterIncomesIndex,
                        items: incomeTypeItems,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: SfCartesianChart(
                    primaryXAxis: const CategoryAxis(),
                    series: <CartesianSeries<ReportsCategoryModel, String>>[
                      BarSeries<ReportsCategoryModel, String>(
                          dataSource: reportsCubit.reportsCategories,
                          xValueMapper: (ReportsCategoryModel data, index) =>
                              data.name,
                          yValueMapper: (ReportsCategoryModel data, index) =>
                              data.amount,
                          color: const Color.fromRGBO(8, 142, 255, 1))
                    ]),
              ),
            ],
          ),
        ));
      },
    );
  }
}
