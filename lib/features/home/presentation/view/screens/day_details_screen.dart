import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/helpers/methos_helper/methods_helper.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/home/presentation/manager/home_cubit.dart';
import 'package:masrofatak/features/home/presentation/view/widgets/expenses_incomes_item.dart';

import '../../../../../core/app_theme/colors/app_colors.dart';

class DayDetailsScreen extends StatefulWidget {
  const DayDetailsScreen({super.key});

  static const name = '/dayDetails';

  @override
  State<DayDetailsScreen> createState() => _DayDetailsScreenState();
}

class _DayDetailsScreenState extends State<DayDetailsScreen> {
  final categoryCubit = getIt<CategoryCubit>();
  final homeCubit = getIt<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('DayDetails')),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            Text(
              '${MethodsHelper.convert(context, homeCubit.expensesIncomesPerDay[0].day)} / ${MethodsHelper.convert(context, homeCubit.expensesIncomesPerDay[0].month)}',
              style: AppStyles.styleRegular16.copyWith(
                  color: AppColors.color424242, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 15.w),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => Card(
                    elevation: 3 ,
                    child: Padding(
                      padding: EdgeInsets.all(5.w),
                      child: ExpensesIncomesSmallItem(
                            isWidgetIntrinsic: true,
                            color: categoryCubit.getCategoryColor,
                            expensesIncomesModel:
                                homeCubit.expensesIncomesPerDay[index],
                          ),
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 20.h),
                  itemCount: homeCubit.expensesIncomesPerDay.length),
            ),
          ],
        ),
      ),
    );
  }
}
