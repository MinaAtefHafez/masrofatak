// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReportsCategoryModel {
  final String? name;
  final int? amount;
  final String? dateTime;

  ReportsCategoryModel({this.dateTime, this.name, this.amount});

  ReportsCategoryModel copyWith({
    String? name,
    int? amount,
    String? dateTime,
  }) {
    return ReportsCategoryModel(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
