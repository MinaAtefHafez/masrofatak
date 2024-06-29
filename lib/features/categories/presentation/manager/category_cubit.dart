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

  List<CategoryModel> expensesCategories = [
    CategoryModel(name: 'Shopping', id: 0, icon: Assets.imagesShopping),
    CategoryModel(name: 'Gifts', id: 1, icon: Assets.imagesCardGiftcard),
    CategoryModel(name: 'Bar & Cafe', id: 2, icon: Assets.imagesBarCafe),
    CategoryModel(name: 'Health', id: 3, icon: Assets.imagesHealth),
    CategoryModel(name: 'Transportation', id: 4, icon: Assets.imagesVehicle),
    CategoryModel(name: 'Electronics', id: 5, icon: Assets.imagesElectronics),
    CategoryModel(name: 'Personal', id: 6, icon: Assets.imagesLaundry),
    CategoryModel(name: 'Liquor', id: 7, icon: Assets.imagesLiquor),
    CategoryModel(
        name: 'Restaurant', id: 8, icon: Assets.imagesRestaurantBlack24dp)
  ];

  List<CategoryModel> incomesCategories = [
    CategoryModel(name: 'Salary', id: 0, icon: Assets.imagesSalary),
    CategoryModel(name: 'Gifts', id: 1, icon: Assets.imagesCardGiftcard),
    CategoryModel(name: 'Savings', id: 2, icon: Assets.imagesSavings),
    CategoryModel(name: 'Wages', id: 3, icon: Assets.imagesWages),
    CategoryModel(name: 'Interest', id: 4, icon: Assets.imagesInterest),
    CategoryModel(name: 'Other', id: 5, icon: Assets.imagesAllowance),
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

  List<CategoryModel> getExpensesOrIncomesCategories(bool isExpenses) {
    return isExpenses ? expensesCategories : incomesCategories;
  }

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

  Future<void> saveExpensesCategoriesLocal() async {
    await _categoryRepo.saveExpensesCategoriesLocal(expensesCategories);
    emit(SaveAllCategoriesLocal());
  }

  Future<void> getExpensesCategoriesLocal() async {
    expensesCategories = await _categoryRepo.getExpensesCategoriesLocal();
    emit(GetAllCategoriesLocal());
  }

  Future<void> saveIncomesCategoriesLocal() async {
    await _categoryRepo.saveIncomesCategoriesLocal(incomesCategories);
    emit(SaveAllCategoriesLocal());
  }

  Future<void> getIncomesCategoriesLocal() async {
    incomesCategories = await _categoryRepo.getIncomesCategoriesLocal();
    emit(GetAllCategoriesLocal());
  }
}
