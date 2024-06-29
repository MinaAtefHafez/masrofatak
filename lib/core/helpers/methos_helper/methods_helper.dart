import 'package:flutter/material.dart';
import 'package:masrofatak/core/helpers/localization_helper/localization_helper.dart';

abstract class MethodsHelper {
  static String replaceArabicNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(arabic[i], english[i]);
    }

    return input;
  }

  static String replaceEnglishNumber(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }

    return input;
  }

  static String convert(BuildContext ctx, String input)  {
    return LocalizationUtils.isArabic
        ? replaceEnglishNumber(input)
        : replaceArabicNumber(input);
  }
}
