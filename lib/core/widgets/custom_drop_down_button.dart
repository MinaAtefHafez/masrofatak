import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';

import '../app_theme/colors/app_colors.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.value});

  final List<String> items;
  final Function(int? value) onChanged;
  final int value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none)),
        elevation: 3,
        style: AppStyles.styleMedium13.copyWith(color: AppColors.color424242),
        icon: const Icon(Icons.arrow_drop_down),
        value: value,
        borderRadius: BorderRadius.circular(15.r),
        items: items
            .map((e) => DropdownMenuItem<int>(
                value: items.indexOf(e),
                child: Text(tr(e),
                    style: AppStyles.styleMedium13
                        .copyWith(color: AppColors.color424242))))
            .toList(),
        onChanged: onChanged);
  }
}
