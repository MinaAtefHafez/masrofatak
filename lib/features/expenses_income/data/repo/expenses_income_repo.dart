import 'package:masrofatak/core/helpers/hive_helper/hive_helper.dart';


abstract class ExpensesIncomeRepo {
  Future<void> saveExpensesIncomeLocal(List<dynamic> data);
  Future<dynamic> getExpensesIncomeLocal();
}

class ExpensesIncomeRepoImpl extends ExpensesIncomeRepo {
  @override
  Future<void> getExpensesIncomeLocal() {
    var data = HiveHelper.getData(key: HiveConstants.expensesIncome);
    return data;
  }

  @override
  Future<void> saveExpensesIncomeLocal(List<dynamic> data) async {
    HiveHelper.putData(key: HiveConstants.expensesIncome, value: data);
  }
}
