enum MoneyType { expenses, incomes }

MoneyType getMoneyType(String type) {
  final moneyType = switch (type) {
    'Expenses' => MoneyType.expenses,
    _ => MoneyType.incomes
  };
  return moneyType;
}
