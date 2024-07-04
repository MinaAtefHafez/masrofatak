import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masrofatak/core/app_styles/app_styles.dart';

class LanguageBottomSheetWidget extends StatefulWidget {
  const LanguageBottomSheetWidget(
      {super.key, required this.value, required this.onChanged});

  final int value;
  final Function(int? value) onChanged;

  @override
  State<LanguageBottomSheetWidget> createState() =>
      _LanguageBottomSheetWidgetState();
}

class _LanguageBottomSheetWidgetState extends State<LanguageBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Radio<int>(
                value: 0,
                groupValue: widget.value,
                onChanged: widget.onChanged),
            Text('اللغة العربية', style: AppStyles.styleRegular16),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          children: [
            Radio<int>(
                value: 1,
                groupValue: widget.value,
                onChanged: widget.onChanged),
            Text('English', style: AppStyles.styleRegular16),
          ],
        ),
      ],
    );
  }
}
