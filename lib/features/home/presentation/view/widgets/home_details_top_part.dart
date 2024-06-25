import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/gen/app_images.dart';

import '../../../../../core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';

class HomeDetailsTopPart extends StatelessWidget {
  const HomeDetailsTopPart({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.imagesLogo,
          width: 32.w,
          height: 32.h,
        ),
        SizedBox(width: 10.w),
        Text(tr('Masrofatk'),
            style: AppStyles.styleSemiBold20.copyWith(
                fontWeight: FontWeight.w700, color: AppColors.color424242)),
        const Spacer(),
        InkWell(
            onTap: () {},
            child: SvgPicture.asset(Assets.imagesSearch,
                width: 24.w, height: 24.h))
      ],
    );
  }
}
