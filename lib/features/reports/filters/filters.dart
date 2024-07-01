
import 'package:masrofatak/features/reports/data/models/reports_model.dart';

abstract class FiltersTimes {
  Future<List<ReportsCategoryModel>> filter(List<ReportsCategoryModel> reports);
}

class FiltersDay extends FiltersTimes {
  @override
  Future<List<ReportsCategoryModel>> filter(
      List<ReportsCategoryModel> reports) async {
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 1));
    reports = reports.where((e) {
      var date = DateTime.parse(e.dateTime!);
      return date.isAfter(now_1w);
    }).toList();
    return reports;
  }
}

class FiltersWeek extends FiltersTimes {
  @override
  Future<List<ReportsCategoryModel>> filter(
      List<ReportsCategoryModel> reports) async {
    var now = DateTime.now();
    var now_1w = now.subtract(const Duration(days: 7));
    reports = reports.where((e) {
      var date = DateTime.parse(e.dateTime!);
      return  date.isAfter(now_1w);
    }).toList();
    return reports;
  }
}

class FiltersMonth extends FiltersTimes {
  @override
  Future<List<ReportsCategoryModel>> filter(
      List<ReportsCategoryModel> reports) async {
    var now = DateTime.now();
    var now_1w = DateTime(now.year, now.month - 1, now.day);
    reports = reports.where((e) {
      var date = DateTime.parse(e.dateTime!);
      return date.isAfter(now_1w);
    }).toList();
    return reports;
  }
}

abstract class FilterFactory {
  static FiltersTimes getFilter(int index) {
    switch (index) {
      case 0:
        return FiltersDay();
      case 1:
        return FiltersWeek();
      case 2:
        return FiltersMonth();
      default:
        return FiltersDay();
    }
  }
}
