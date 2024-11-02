import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PendingTransactionModel {
  String transactionId;
  DateTime transctionDate;
  String amount;
  bool isExpense;
  PendingTransactionModel({
    required this.transactionId,
    required this.transctionDate,
    required this.amount,
    required this.isExpense,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'transctionDate': transctionDate,
      'amount': amount,
      'isExpense': isExpense,
    };
  }

  factory PendingTransactionModel.fromMap(Map<String, dynamic> map) {
    return PendingTransactionModel(
      transactionId: map["TransactionId"] as String,
      transctionDate:
          DateTime.fromMillisecondsSinceEpoch(map["TransactionDate"] as int),
      amount: map["TransactionAmount"] as String,
      isExpense: (map["TransactionType"] as String).toLowerCase() == "expense",
    );
  }

  String toJson() => json.encode(toMap());

  factory PendingTransactionModel.fromJson(String source) =>
      PendingTransactionModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
