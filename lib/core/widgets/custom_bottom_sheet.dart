import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void customBottomSheet(BuildContext context,
    {required Widget widget, double? minHeight, double? maxHeight}) {
  showBottomSheet(
      context: context,
    
      backgroundColor: Colors.grey.shade100,
      constraints: BoxConstraints(
          minHeight: minHeight ?? 390.h, maxHeight: maxHeight ?? 390.h),
      shape: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      elevation: 10,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: widget,
          ));
}
