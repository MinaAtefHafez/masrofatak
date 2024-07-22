import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_states.dart';
import 'package:masrofatak/features/categories/presentation/view/screens/add_new_category_screen.dart';
import '../../../../expenses_income/presentation/view/widgets/expenses_income_button.dart';

class CategorySettingsScreen extends StatefulWidget {
  const CategorySettingsScreen({super.key});

  static const name = '/categorySettings';

  @override
  State<CategorySettingsScreen> createState() => _CategorySettingsScreenState();
}

class _CategorySettingsScreenState extends State<CategorySettingsScreen> {
  final categoryCubit = getIt<CategoryCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      bloc: categoryCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tr('ManageCategories')),
          ),
          body: Column(
            children: [
              SizedBox(height: 20.h),
              ExpensesIncomeButton(
                isExpense: categoryCubit.isExpenses,
                onTapExpenses: categoryCubit.onTapExpenses,
                onTapIncome: categoryCubit.onTapIncomes,
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  itemCount: categoryCubit.categories.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: SvgPicture.asset(
                        categoryCubit.categories[index].icon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                    title: Text(
                      categoryCubit.categories[index].name,
                      style: AppStyles.styleMedium13,
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        )),
                  ),
                  separatorBuilder: (context, index) => SizedBox(height: 10.h),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              CustomNavigator.pushNamed(AddNewCategoryScreen.name);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
