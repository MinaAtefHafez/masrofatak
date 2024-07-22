import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('ManageCategories')),
      ),
      body: Column(
        children: [
          ExpensesIncomeButton(
            isExpense: categoryCubit.isExpenses,
            onTapExpenses: (){} ,
            onTapIncome: (){} ,
          ),
          Expanded(
            child: ListView.separated(
             itemCount:  , 
             itemBuilder: (context, index) =>  ,
             separatorBuilder: (context, index) => SizedBox(height: 10.h) ,
             ),
          ),
        ],
      ) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CustomNavigator.pushNamed(AddNewCategoryScreen.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
