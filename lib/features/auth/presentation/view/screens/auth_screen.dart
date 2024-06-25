import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import '../../../../../core/app_theme/colors/app_colors.dart';
import '../../../../../core/gen/app_images.dart';
import '../widgets/auth_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const name = '/auth';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.imagesLogo,
              width: 86.w,
              height: 86.h,
            ),
            SizedBox(height: 24.h),
            Text(tr('Masrofatk'), style: AppStyles.styleSemiBold24),
            SizedBox(height: 4.h),
            Text(tr('YourExpenseManager'),
                style: AppStyles.styleRegular14
                    .copyWith(color: AppColors.color616161)),
            SizedBox(height: 40.h),
            Text(tr('CreateUnAccount'),
                style: AppStyles.styleSemiBold20
                    .copyWith(color: AppColors.color424242)),
            SizedBox(height: 8.h),
            Text(
              tr('CreateAccountDescription'),
              style: AppStyles.styleRegular14
                  .copyWith(color: AppColors.color424242),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 56.h),
            AuthButton(onTap: () {}),
          ],
        ),
      )),
    );
  }
}
