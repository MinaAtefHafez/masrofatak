// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllMoneyModel {
  final int? incomes;
  final int? expenses;
  final int? balance;

  AllMoneyModel({this.incomes, this.expenses, this.balance});

  AllMoneyModel copyWith({
    int? incomes,
    int? expenses,
    int? balance,
  }) {
    return AllMoneyModel(
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      balance: balance ?? this.balance,
    );
  }
}
