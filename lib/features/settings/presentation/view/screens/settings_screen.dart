import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/core/helpers/localization_helper/localization_helper.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const name = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr('Settings')),
      ),
      body: Center(
          child: Column(
        children: [
          InkWell(
            onTap: () {},
            child: ListTile(
              leading: SvgPicture.asset(Assets.imagesLanguage,
                  width: 24, height: 24),
              title: Text(tr('Language'), style: AppStyles.styleRegular14),
              trailing: Icon(
                  LocalizationUtils.isArabic
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_back_ios,
                  size: 18.w),
            ),
          ),
          SizedBox(height: 10.h),
          InkWell(
            onTap: () {},
            child: ListTile(
              leading:
                  SvgPicture.asset(Assets.imagesManage, width: 24, height: 24),
              title:
                  Text(tr('ManageCategories'), style: AppStyles.styleRegular14),
              trailing: Icon(
                  LocalizationUtils.isArabic
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_back_ios,
                  size: 18.w),
            ),
          )
        ],
      )),
    );
  }
}
