import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';
import '../../../../../core/dependency_injection/dependency_injection.dart';
import '../../../../categories/presentation/manager/category_cubit.dart';

class CategoriesIconsBottomSheerWidget extends StatefulWidget {
  const CategoriesIconsBottomSheerWidget(
      {super.key, required this.icons});

  final List<String> icons;

  @override
  State<CategoriesIconsBottomSheerWidget> createState() =>
      _ExpensesCategoryBottomSheerWidgetState();
}

class _ExpensesCategoryBottomSheerWidgetState
    extends State<CategoriesIconsBottomSheerWidget> {
  final categoryCubit = getIt<CategoryCubit>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(tr('ChooseCategoryIcon'),
            style:
                AppStyles.styleMedium13.copyWith(color: AppColors.color424242)),
        SizedBox(height: 20.h),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            padding: EdgeInsets.zero,
            itemCount: widget.icons.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  categoryCubit.onCategoryIconChanged(widget.icons[index]);
                },
                child: Column(
                  children: [
                    UnconstrainedBox(
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: categoryCubit.getCategoryColor,
                            shape: BoxShape.circle),
                        child: UnconstrainedBox(
                          child: SvgPicture.asset(
                            widget.icons[index],
                            width: 32.w,
                            height: 32.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        
      ],
    );
  }
}
