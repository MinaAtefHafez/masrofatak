
import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: SfCartesianChart(
            primaryXAxis: const CategoryAxis(),
            primaryYAxis:
                const NumericAxis(minimum: 0, maximum: 40, interval: 10),
            series: <CartesianSeries<ReportsCategoryModel, String>>[
              BarSeries<ReportsCategoryModel, String>(
                  dataSource: reportsCubit.reportExpensesCategories,
                  xValueMapper: (ReportsCategoryModel data, _) => data.name,
                  yValueMapper: (ReportsCategoryModel data, _) => data.amount,
                  name: 'Gold',
                  color: const Color.fromRGBO(8, 142, 255, 1))
            ]));
  }
}


