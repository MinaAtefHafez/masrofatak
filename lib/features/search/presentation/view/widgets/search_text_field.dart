import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';

import '../../../../../core/gen/app_images.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
          suffixIcon: UnconstrainedBox(
            child: SvgPicture.asset(
              Assets.imagesSearch,
              width: 24.w,
              height: 24.h,
            ),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: tr('Search'),
          hintStyle: AppStyles.styleMedium13 ,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          )),
    );
  }
}
