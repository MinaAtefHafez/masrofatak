import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/core/router/routes.dart';

import 'core/app_theme/app_theme.dart';
import 'core/helpers/localization_helper/localization_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      minTextAdapt: true,
      ensureScreenSize: true,
      builder: (context, child) {
        LocalizationUtils.init(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: CustomRouter.onGenerateRoutes,
          navigatorKey: navigatorKey ,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: AppTheme.lightTheme,
        );
      },
    );
  }
}
