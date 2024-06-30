import 'package:flutter/material.dart';

Future<DateTime?> customDatePicker(BuildContext ctx) async {
  DateTime? picked = await showDatePicker(
    context: ctx,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime.now(),
  );

  if (picked != null) {
    return picked;
  } else {
    return null;
  }
}
