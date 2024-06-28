
abstract class ExpensesIncomeState {}

final class InitialState extends ExpensesIncomeState {}

final class OnTypeIncomeChanged extends ExpensesIncomeState {}

final class SaveExpensesIncomeLocal extends ExpensesIncomeState {}

final class GetExpensesIncomesLocal extends ExpensesIncomeState {
  final List<dynamic> expensesIncomes;

  GetExpensesIncomesLocal(this.expensesIncomes);
}
