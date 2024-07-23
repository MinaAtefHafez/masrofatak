import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/core/helpers/localization_helper/localization_helper.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/core/widgets/custom_bottom_sheet.dart';
import 'package:masrofatak/features/settings/presentation/manager/settings_cubit.dart';
import 'package:masrofatak/features/settings/presentation/manager/settings_state.dart';
import 'package:masrofatak/features/settings/presentation/view/widgets/language_bottom_sheet_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const name = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final settingsCubit = getIt<SettingsCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(tr('Settings')),
      ),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        bloc: settingsCubit,
        listener: (context, state) {
          if (state is ChangeLanguageState) {
            if (state.value == 0) {
              LocalizationUtils.changeLocale('ar');
            } else {
              LocalizationUtils.changeLocale('en');
            }
            CustomNavigator.pop();
          }
        },
        builder: (context, state) {
          return Center(
              child: Column(
            children: [
              InkWell(
                onTap: () {
                  customBottomSheet(context,
                      maxHeight: 250.h,
                      minHeight: 250.h,
                      widget: LanguageBottomSheetWidget(
                        value: settingsCubit.languageRadioValue,
                        onChanged: (value) {
                          settingsCubit.changeLanguage(value!);
                        },
                      ));
                },
                child: ListTile(
                  leading: SvgPicture.asset(Assets.imagesLanguage,
                      width: 24, height: 24),
                  title: Text(tr('Language'), style: AppStyles.styleRegular14),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18.w),
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
