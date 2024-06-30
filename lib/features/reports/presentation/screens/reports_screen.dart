import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/features/reports/data/models/reports_model.dart';
import 'package:masrofatak/features/reports/presentation/manager/reports_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  static const name = '/reporsts';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final reportsCubit = getIt<ReportsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 30.h),
          child: SfCartesianChart(
              primaryXAxis: const CategoryAxis(),
              series: <CartesianSeries<ReportsCategoryModel, String>>[
            BarSeries<ReportsCategoryModel, String>(
                dataSource: reportsCubit.reportExpensesCategories,
                xValueMapper: (ReportsCategoryModel data, index) => data.name,
                yValueMapper: (ReportsCategoryModel data, index) => data.amount,
                color: const Color.fromRGBO(8, 142, 255, 1))
          ]),
        ));
  }
}
