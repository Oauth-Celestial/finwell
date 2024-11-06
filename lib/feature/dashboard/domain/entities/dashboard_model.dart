// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';

class DashboardModel {
  String expenseAmount;
  String incomeAmount;

  List<TransactionModel> recenntTransactions;
  DashboardModel({
    required this.expenseAmount,
    required this.incomeAmount,
    required this.recenntTransactions,
  });

  DashboardModel copyWith({
    String? expenseAmount,
    String? incomeAmount,
    List<TransactionModel>? recenntTransactions,
  }) {
    return DashboardModel(
      expenseAmount: expenseAmount ?? this.expenseAmount,
      incomeAmount: incomeAmount ?? this.incomeAmount,
      recenntTransactions: recenntTransactions ?? this.recenntTransactions,
    );
  }
}
