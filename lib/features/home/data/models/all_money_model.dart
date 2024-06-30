// ignore_for_file: public_member_api_docs, sort_constructors_first
class AllMoneyModel {
  final String? incomes;
  final String? expenses;
  final String? balance;

  AllMoneyModel({this.incomes, this.expenses, this.balance});

  AllMoneyModel copyWith({
    String? incomes,
    String? expenses,
    String? balance,
  }) {
    return AllMoneyModel(
      incomes: incomes ?? this.incomes,
      expenses: expenses ?? this.expenses,
      balance: balance ?? this.balance,
    );
  }
}
