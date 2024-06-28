import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

class ExpesesIncomesDivider extends StatelessWidget {
  const ExpesesIncomesDivider({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          count,
          (index) => Expanded(
                child: Container(
                  color:
                      index.isEven ? AppColors.color424242 : Colors.transparent,
                  height: 1.h,
                ),
              )),
    );
  }
}
