import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/search/presentation/manager/search_cubit.dart';
import 'package:masrofatak/features/search/presentation/manager/search_states.dart';
import 'package:masrofatak/features/search/presentation/view/widgets/search_expenses_incomes_item.dart';

import '../../../../../core/app_theme/colors/app_colors.dart';
import '../widgets/search_categories_list_view.dart';
import '../widgets/search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  static const name = '/search';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final textController = TextEditingController();
  final searchCubit = getIt<SearchCubit>();
  final categoryCubit = getIt<CategoryCubit>();
  @override
  void initState() {
    super.initState();
    call();
    textController.addListener(() async {
      searchCubit.searchOnItem(textController.text);
    });
  }

  void call() async {
    await searchCubit.mergeIncomesAndExpensesCategories();
    await searchCubit.initSearchMap();
  }

  @override
  void dispose() {
    super.dispose();
    searchCubit.initSearchMap();
    searchCubit.clearSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchCubit, SearchStates>(
        bloc: searchCubit,
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 50.h),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          CustomNavigator.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        )),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: SearchTextField(
                          textController: textController,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                if (searchCubit.searchMap.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: SizedBox(
                        height: 43.h,
                        child: SearchCategoriesListView(
                          onTap: (index) async {
                            await searchCubit.chooseCategoryFromMap(
                                searchCubit.allCategories[index].name!);
                            await searchCubit
                                .searchOnItem(textController.text.trim());
                          },
                          searchMap: searchCubit.searchMap,
                          categories: searchCubit.allCategories,
                        )),
                  ),
                ],
                SizedBox(height: 15.h),
                Divider(thickness: 1, color: Colors.grey.withOpacity(0.5)),
                SizedBox(height: 15.h),
                if (searchCubit.searchList.isNotEmpty) ...[
                  Expanded(
                    child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: searchCubit.searchList.length,
                        itemBuilder: (context, index) => Card(
                              color: Colors.grey.shade100,
                              elevation: 3,
                              child: Padding(
                                padding: EdgeInsets.all(5.w),
                                child: SearchExpensesIncomesItem(
                                  expensesIncomeModel:
                                      searchCubit.searchList[index],
                                ),
                              ),
                            )),
                  ),
                ] else ...[
                  Center(
                    child: Text(
                      tr('NoData'),
                      style: AppStyles.styleRegular16
                          .copyWith(color: AppColors.color424242),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
