import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/features/categories/data/repo/category_repo.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';
import '../../data/models/categories_model.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this._categoryRepo) : super(InitialState());

  final CategoryRepo _categoryRepo;

  bool isExpenses = true;

  CategoryModel categoryModel = CategoryModel();

  List<dynamic> expensesCategories = [
    CategoryModel(name: 'Shopping', id: 0, icon: Assets.imagesShopping),
    CategoryModel(name: 'Gifts', id: 1, icon: Assets.imagesCardGiftcard),
    CategoryModel(name: 'Bar & Cafe', id: 2, icon: Assets.imagesBarCafe),
    CategoryModel(name: 'Health', id: 3, icon: Assets.imagesHealth),
    CategoryModel(name: 'Transportation', id: 4, icon: Assets.imagesVehicle),
    CategoryModel(name: 'Electronics', id: 5, icon: Assets.imagesElectronics),
    CategoryModel(name: 'Personal', id: 6, icon: Assets.imagesLaundry),
    CategoryModel(
        name: 'Restaurant', id: 8, icon: Assets.imagesRestaurantBlack24dp)
  ];

  List<String> categoriesIcons = [
    Assets.imagesFootball,
    Assets.imagesHealth,
    Assets.imagesElectronics,
    Assets.imagesInterest,
    Assets.imagesSalary,
    Assets.imagesSavings,
    Assets.imagesShopping,
    Assets.imagesWages,
    Assets.imagesBarCafe,
    Assets.imagesVehicle,
    Assets.imagesCardGiftcard,
    Assets.imagesLaundry,
    Assets.imagesRestaurantBlack24dp,
    Assets.imagesLiquor,
    Assets.imagesSchoolBlack24dp,
    Assets.imagesConstructionBlack24dp,
    Assets.imagesYoga,
  ];

  List<dynamic> incomesCategories = [
    CategoryModel(name: 'Salary', id: 0, icon: Assets.imagesSalary),
    CategoryModel(name: 'Gifts', id: 1, icon: Assets.imagesCardGiftcard),
    CategoryModel(name: 'Savings', id: 2, icon: Assets.imagesSavings),
    CategoryModel(name: 'Wages', id: 3, icon: Assets.imagesWages),
  ];

  Future<void> addToExpensesCategories() async {
    expensesCategories.add(categoryModel);
  }

  void onCategoryIconChanged(String urlIcon) {
    categoryModel = categoryModel.copyWith(icon: urlIcon);
    emit(OnCategoryIconChanged());
  }

  Future<void> addToIncomesCategories() async {
    incomesCategories.add(categoryModel);
  }

  Future<void> addToExpensesOrIncomes() async {
    if (isExpenses) {
      await addToExpensesCategories();
    } else {
      await addToIncomesCategories();
    }
    emit(AddToExpensesOrIncomes());
  }

  void onCategoryNameChanged(String value) {
    categoryModel = categoryModel.copyWith(name: value);
  }

  void onTapExpenses() {
    isExpenses = true;
    emit(ChooseExpensesOrIncomesToAddCategory());
  }

  void onTapIncomes() {
    isExpenses = false;
    emit(ChooseExpensesOrIncomesToAddCategory());
  }

  List<dynamic> getExpensesOrIncomesCategories(bool isExpenses) {
    return isExpenses ? expensesCategories : incomesCategories;
  }

  Future<void> saveExpensesCategoriesLocal() async {
    await _categoryRepo.saveExpensesCategoriesLocal(expensesCategories);
    emit(SaveAllCategoriesLocal());
  }

  Future<void> getExpensesCategoriesLocal() async {
    expensesCategories = await _categoryRepo.getExpensesCategoriesLocal();
    emit(GeExpensesCategoriesLocal(expensesCategories));
  }

  Future<void> saveIncomesCategoriesLocal() async {
    await _categoryRepo.saveIncomesCategoriesLocal(incomesCategories);
    emit(SaveAllCategoriesLocal());
  }

  Future<void> getIncomesCategoriesLocal() async {
    incomesCategories = await _categoryRepo.getIncomesCategoriesLocal();
    emit(GetIncomesCategoriesLocal(incomesCategories));
  }
}
