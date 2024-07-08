import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/features/categories/data/models/categories_model.dart';
import 'dart:ui' as ui;

import '../../../../../core/app_theme/colors/app_colors.dart';

class SearchCategoriesListViewItem extends StatelessWidget {
  const SearchCategoriesListViewItem(
      {super.key, required this.categoryModel, required this.isActive});

  final CategoryModel categoryModel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: isActive ? Colors.blue.withOpacity(0.4) : null,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.colorBDBDBD, width: 1.w)),
      child: Directionality(
        textDirection: ui.TextDirection.ltr,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              categoryModel.icon!,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 5.w),
            Text(categoryModel.name!,
                style: AppStyles.styleRegular14
                    .copyWith(color: AppColors.color424242)),
          ],
        ),
      ),
    );
  }
}
