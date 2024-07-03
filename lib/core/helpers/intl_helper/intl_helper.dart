import 'package:intl/intl.dart';

abstract class IntlHelper {
  static final dayNow = DateTime.now().day.toString();
  static final monthNow = DateTime.now().month.toString();
  static final yearNow = DateTime.now().year.toString();
  static String get dateTimeNow => DateTime.now().toString();
  static String month([int? month]) => DateFormat('MMMM').format(DateTime(
      int.parse(IntlHelper.yearNow), month ?? int.parse(IntlHelper.monthNow)));
}
