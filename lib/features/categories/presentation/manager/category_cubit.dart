import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/features/categories/data/repo/category_repo.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';
import '../../../../core/app_theme/colors/app_colors.dart';
import '../../data/models/categories_model.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._categoryRepo) : super(InitialState());

  final CategoryRepo _categoryRepo;

  CategoryModel category =
      CategoryModel(name: 'Grocery', id: 0, icon: Assets.imagesShopping);

  List<CategoryModel> categories = [
    CategoryModel(name: 'Grocery', id: 0, icon: Assets.imagesShopping),
    CategoryModel(name: 'Gifts', id: 1, icon: Assets.imagesCardGiftcard),
    CategoryModel(name: 'Bar & Cafe', id: 2, icon: Assets.imagesBarCafe),
    CategoryModel(name: 'Health', id: 3, icon: Assets.imagesHealth),
    CategoryModel(name: 'Commute', id: 4, icon: Assets.imagesVehicle),
    CategoryModel(name: 'Electronics', id: 5, icon: Assets.imagesElectronics),
    CategoryModel(name: 'Laundry', id: 6, icon: Assets.imagesLaundry),
    CategoryModel(name: 'Liquor', id: 7, icon: Assets.imagesLiquor),
    CategoryModel(
        name: 'Restaurant', id: 8, icon: Assets.imagesRestaurantBlack24dp)
  ];

  List<Color> categoriesColors = [
    AppColors.color1C8E6C9,
    AppColors.color2FFECB3,
    AppColors.color3FFCDD2,
    AppColors.color4E1BEE7,
    AppColors.color5B3E5FC,
    AppColors.color6BBDEFB,
    AppColors.color7DCEDC8,
    AppColors.color8D7CCC8,
    AppColors.color9B39DDB,
    AppColors.color11CFD8DC,
    AppColors.color12F8BBD0,
    AppColors.color13B2EBF2,
    AppColors.color14C5CAE9,
    AppColors.color15E6EE9C,
    AppColors.color16FFE0B2,
    AppColors.color17FFF9C4
  ];

  Color get getCategoryColor {
    var random = Random();
    var colorIndex = random.nextInt(categoriesColors.length - 1);
    return categoriesColors[colorIndex];
  }

  Future<void> chooseCategory(CategoryModel categ) async {
    category = categ;
    emit(ChooseCategory());
  }

  CategoryModel get getCategory => category;

  Future<void> saveAllCategoriesLocal() async {
    await _categoryRepo.saveAllCategoriesLocal(categories);
    emit(SaveAllCategoriesLocal());
  }

  Future<void> getAllCategoriesLocal() async {
    categories = await _categoryRepo.getAllCategoriesLocal();
    emit(GetAllCategoriesLocal());
  }
}
