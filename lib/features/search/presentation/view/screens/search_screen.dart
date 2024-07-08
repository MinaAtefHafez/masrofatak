import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/dependency_injection/dependency_injection.dart';
import 'package:masrofatak/core/router/navigation.dart';
import 'package:masrofatak/features/search/presentation/manager/search_cubit.dart';
import 'package:masrofatak/features/search/presentation/manager/search_states.dart';

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

  @override
  void initState() {
    super.initState();
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
              ],
            ),
          );
        },
      ),
    );
  }
}
