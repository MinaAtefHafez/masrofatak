import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../categories/data/models/categories_model.dart';

import 'search_categories_list_view_item.dart';

class SearchCategoriesListView extends StatelessWidget {
  const SearchCategoriesListView(
      {super.key,
      required this.categories,
      required this.onTap,
      required this.searchMap});

  final List<CategoryModel> categories;
  final Function(int) onTap;
  final Map<String, bool> searchMap;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => InkWell(
          onTap: () => onTap(index),
          child: SearchCategoriesListViewItem(
            categoryModel: categories[index],
            isActive: searchMap[categories[index].name]!,
          )),
      separatorBuilder: (context, index) => SizedBox(width: 5.w),
    );
  }
}
