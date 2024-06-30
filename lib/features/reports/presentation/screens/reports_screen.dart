import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../../../../core/app_theme/colors/app_colors.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  static const name = '/reporsts';

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 10.w, right: 10.w, top: 30.h, bottom: 10.h),
        child: SfCartesianChart(
          series: [
            BarSeries(
              dataSource: const ['a', 'b', 'c', 'd', 'e', 'f' , 'v' , 'n' , 'j' ,
               'z' , 'y' , 'x'
              ],
              xValueMapper: (value, index) => index,
              yValueMapper: (value, index) => 20,
            )
          ],
        ),
      ),
    );
  }
}
