import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';

abstract class CustomSnackBar {
  static customSnackBar(BuildContext context,
      {required String text, Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      duration: const Duration(seconds: 4 ),
      padding: EdgeInsets.symmetric(horizontal: 15.w , vertical: 5.h  ),
      elevation: 0 ,
      dismissDirection: DismissDirection.up ,
       behavior: SnackBarBehavior.floating,
       margin: EdgeInsets.only(left: 20.w , right: 20.w , bottom: MediaQuery.sizeOf(context).height - 210   ),  
      content: Text(text,
          style:
              AppStyles.styleRegular14.copyWith(color: Colors.black )),
      backgroundColor: color ?? Colors.green,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r) ,
       borderSide: BorderSide.none
      ),
    ));
  }
}
