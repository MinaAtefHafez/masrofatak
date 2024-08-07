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
    call();
  }

  void call() async {
    await searchCubit.mergeIncomesAndExpensesCategories();
    await searchCubit.initSearchMap();
    await searchCubit.search(textController.text.trim());
    textController.addListener(() async {
      searchCubit.search(textController.text.trim());
    });
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
            padding: EdgeInsets.only(top: 50.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.h),
                  child: Row(
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
                          height: 45.h,
                          child: SearchTextField(
                            textController: textController,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                                .search(textController.text.trim());
                          },
                          searchMap: searchCubit.searchMap,
                          categories: searchCubit.allCategories,
                        )),
                  ),
                ],
                SizedBox(height: 15.h),
                Divider(thickness: 1, color: Colors.grey.withOpacity(0.5)),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.w, right: 10.w, bottom: 20.h),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
