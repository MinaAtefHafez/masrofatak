import 'package:flutter/material.dart';
import 'package:masrofatak/core/widgets/custom_drop_down_button.dart';

class ReportsDropDownButton extends StatefulWidget {
  const ReportsDropDownButton({super.key, required this.onChanaged, required this.value, required this.items});

  final Function(int? value) onChanaged;
  final int value ;
  final List <String> items ;

  @override
  State<ReportsDropDownButton> createState() => _ReportsDropDownButtonState();
}

class _ReportsDropDownButtonState extends State<ReportsDropDownButton> {
  

  @override
  Widget build(BuildContext context) {
    return CustomDropDownButton(
      value: widget.value ,
      items: widget.items,
      onChanged: widget.onChanaged,
    );
  }
}
