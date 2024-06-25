import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/auth/presentation/view/screens/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const name = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _animation1;
  late final Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      CustomNavigator.pushAndReplacementNamed(AuthScreen.name);
    });

    _controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);

    _animation1 = Tween<Offset>(begin: const Offset(5, 0), end: Offset.zero)
        .animate(_controller);

    _animation2 = Tween<Offset>(begin: const Offset(-5, 0), end: Offset.zero)
        .animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.imagesLogo,
              width: 86.w,
              height: 86.h,
            ),
            SizedBox(height: 24.h),
            SlideTransition(
                position: _animation1,
                child: Text(tr('Masrofatk'), style: AppStyles.styleSemiBold24)),
            SizedBox(height: 4.h),
            SlideTransition(
              position: _animation2,
              child: Text(tr('YourExpenseManager'),
                  style: AppStyles.styleRegular14
                      .copyWith(color: AppColors.color616161)),
            ),
          ],
        ),
      ),
    );
  }
}
