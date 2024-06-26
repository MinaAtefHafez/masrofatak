import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

class ExpensesIncomeTextField extends StatelessWidget {
  const ExpensesIncomeTextField(
      {super.key,
      this.controller,
      this.onTap,
      this.label,
      this.readOnly,
      this.hint,
      this.onChanged,
      this.inputType,
       this.initValue});

  final TextEditingController? controller;
  final Function()? onTap;
  final String? label;
  final bool? readOnly;
  final String? hint;
  final Function(String value)? onChanged;
  final TextInputType? inputType;
  final String? initValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      initialValue: initValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: AppColors.color424242)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.blue)),
        labelText: label,
      ),
      keyboardType: inputType,
      readOnly: readOnly ?? false,
      validator: (value) {
        if (value!.isEmpty) {
          return tr('MustNotBeEmpty');
        }
        return null;
      },
    );
  }
}
