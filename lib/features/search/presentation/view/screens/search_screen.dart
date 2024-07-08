import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/categories/presentation/manager/category_cubit.dart';
import 'package:masrofatak/features/search/presentation/manager/search_cubit.dart';
import 'package:masrofatak/features/search/presentation/manager/search_states.dart';
import 'package:masrofatak/features/search/presentation/view/widgets/search_expenses_incomes_item.dart';

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
    textController.addListener(() async {
      if (textController.text.isEmpty) {
        await searchCubit.filterSearchListAccordingCategories();
      }

      await searchCubit
          .filterSearchListAccordingSearchText(textController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchCubit.initSearchMap();
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
                      child: SearchTextField(
                        textController: textController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: SizedBox(
                      height: 43.h,
                      child: SearchCategoriesListView(
                        onTap: (index) async {
                          await searchCubit.chooseCategoryFromMap(
                              searchCubit.allCategories[index].name!);
                          await searchCubit
                              .filterSearchListAccordingCategories();
                        },
                        searchMap: searchCubit.searchMap,
                        categories: searchCubit.allCategories,
                      )),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemCount: searchCubit.searchList.length,
                      itemBuilder: (context, index) => Card(
                            color: Colors.grey.shade100,
                            elevation: 3,
                            child: Padding(
                              padding:  EdgeInsets.all(5.w),
                              child: SearchExpensesIncomesItem(
                                expensesIncomeModel:
                                    searchCubit.searchList[index],
                              ),
                            ),
                          )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
