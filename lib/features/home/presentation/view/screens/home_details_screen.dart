import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/home_basic_item.dart';
import '../widgets/home_date_month_picker.dart';
import '../widgets/home_details_top_part.dart';

class HomeDetailsScreen extends StatefulWidget {
  const HomeDetailsScreen({super.key});

  static const name = '/homeDetails';

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
        child: Column(
          children: [
            HomeDetailsTopPart(onTap: () {}),
            SizedBox(height: 16.h),
            DateMonthPickerItem(
                onTap: () {}, onTapLeft: () {}, onTapRight: () {}),
            SizedBox(height: 30.h),
            const HomeBasicItem(),
          ],
        ),
      ),
    );
  }
}


