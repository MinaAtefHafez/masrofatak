import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/app_theme/colors/app_colors.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/gen/app_images.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/core/widgets/custom_bottom_sheet.dart';
import 'package:masrofatak/core/widgets/custom_date_picker.dart';
import 'package:masrofatak/core/widgets/custom_elevated_button.dart';
import 'package:masrofatak/core/widgets/custom_snack_bar.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/expenses_income/presentation/manager/expenses_income_statesd.dart';
import 'package:masrofatak/features/expenses_income/presentation/view/widgets/expenses_income_button.dart';
import '../../manager/expenses_income_cubit.dart';
import '../widgets/expenses_category_bottom_sheet.dart';
import '../widgets/expenses_income_text_field.dart';

class AddExpensesIncomeScreen extends StatefulWidget {
  const AddExpensesIncomeScreen({super.key});

  static const name = '/addExpensesIncome';

  @override
  State<AddExpensesIncomeScreen> createState() =>
      _AddExpensesIncomeScreenState();
}

class _AddExpensesIncomeScreenState extends State<AddExpensesIncomeScreen> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController categoryTextController;
  final categoryCubit = getIt<CategoryCubit>();
  final expensesIncomeCubit = getIt<ExpensesIncomeCubit>();

  @override
  void initState() {
    super.initState();
    categoryTextController =
        TextEditingController(text: expensesIncomeCubit.getCategory.name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: expensesIncomeCubit,
      child: BlocListener<ExpensesIncomeCubit, ExpensesIncomeState>(
        listener: (context, state) {
          if (state is GetExpensesIncomesLocal) {
            CustomNavigator.pop();
            CustomSnackBar.customSnackBar(context, text: tr('AddDoneSuccess'));
          }
        },
        child: BlocListener<ExpensesIncomeCubit, ExpensesIncomeState>(
          bloc: expensesIncomeCubit,
          listener: (context, state) {
            if (state is OnTypeIncomeChanged || state is ChooseCategories) {
              categoryTextController.text =
                  expensesIncomeCubit.getCategory.name!;
            }
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.colorF5F5F5,
              title: Text(tr('AddNew')),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BlocBuilder<ExpensesIncomeCubit, ExpensesIncomeState>(
                        builder: (context, state) {
                          return ExpensesIncomeButton(
                            isExpense: expensesIncomeCubit.isExpense,
                            onTapExpenses: expensesIncomeCubit.onChooseExpenses,
                            onTapIncome: expensesIncomeCubit.onChooseIncome,
                          );
                        },
                      ),
                      SizedBox(height: 30.h),
                      BlocBuilder<ExpensesIncomeCubit, ExpensesIncomeState>(
                        bloc: expensesIncomeCubit,
                        builder: (context, state) {
                          return ExpensesIncomeTextField(
                            controller: categoryTextController,
                            label: tr('CategoryName'),
                            readOnly: true,
                            onTap: () {
                              customBottomSheet(context,
                                  widget: ExpensesCategoryBottomSheerWidget(
                                    categories: categoryCubit
                                        .getExpensesOrIncomesCategories(
                                            expensesIncomeCubit.isExpense),
                                  ));
                            },
                          );
                        },
                      ),
                      SizedBox(height: 30.h),
                      ExpensesIncomeTextField(
                        inputType: TextInputType.number,
                        hint: tr('EnterAmount'),
                        onChanged: (value) {
                          expensesIncomeCubit.onAmountChanged(value.trim());
                        },
                      ),
                      SizedBox(height: 30.h),
                      ExpensesIncomeTextField(
                        hint: tr('Description'),
                        onChanged: expensesIncomeCubit.onDescriptionChanged,
                      ),
                      SizedBox(height: 20.h),
                      InkWell(
                        onTap: () {
                          showPicker(context);
                        },
                        child: BlocBuilder<ExpensesIncomeCubit,
                            ExpensesIncomeState>(
                          builder: (context, state) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Assets.imagesCalendarToday,
                                  width: 20.w,
                                  height: 20.h,
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                    '${expensesIncomeCubit.expensesIncomeModel.day} / ${expensesIncomeCubit.expensesIncomeModel.month} / ${expensesIncomeCubit.expensesIncomeModel.year}',
                                    style: AppStyles.styleRegular14.copyWith(
                                        color: AppColors.color424242)),
                                Icon(Icons.arrow_drop_down, size: 20.w),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 50.h),
                      BlocBuilder<ExpensesIncomeCubit, ExpensesIncomeState>(
                        builder: (context, state) {
                          return CustomElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await expensesIncomeCubit
                                      .addExpensesOrIncome();
                                }
                              },
                              text: expensesIncomeCubit.isExpense
                                  ? tr('AddExpenses')
                                  : tr('AddIncome'),
                              size: Size(158.w, 32.h));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showPicker(BuildContext ctx) async {
    var picked = await customDatePicker(ctx);
    if (picked != null) {
      var day = picked.day.toString();
      var month = picked.month.toString();
      var year = picked.year.toString();
      expensesIncomeCubit.onDayChanged(day);
      expensesIncomeCubit.onMonthChanged(month);
      expensesIncomeCubit.onYearChanged(year);
      expensesIncomeCubit.onDateTimeChanged(picked.toString());
    }
  }
}
