import 'package:flutter/material.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';

class CategoryModel {
  final String? name;
  final int? id;
  final String? icon;
  CategoryModel({this.icon, this.id, this.name});
}

abstract class CategoriesFactory {
  static Color getCategoryColor(int id) {
    final color = switch (id) {
      1 => AppColors.color1C8E6C9,
      2 => AppColors.color2FFECB3,
      3 => AppColors.color3FFCDD2,
      4 => AppColors.color4E1BEE7,
      5 => AppColors.color5B3E5FC,
      6 => AppColors.color6BBDEFB,
      7 => AppColors.color7DCEDC8,
      8 => AppColors.color8D7CCC8,
      9 => AppColors.color9B39DDB,
      _ => AppColors.color11CFD8DC,
    };
    return color;
  }
}
