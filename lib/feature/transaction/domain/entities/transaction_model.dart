import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  String transactionId;
  String transactionName;
  String transactionType;
  int transactionAmount;
  String transactionCategory;
  DateTime transactionDate;
  TransactionModel(
      {this.transactionId = "",
      required this.transactionName,
      required this.transactionType,
      required this.transactionAmount,
      required this.transactionDate,
      required this.transactionCategory});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'transactionName': transactionName,
      'transactionType': transactionType,
      'transactionAmount': transactionAmount,
      'transactionCategory': transactionCategory,
      'transactionDate': transactionDate,
    };
  }

  String toJson() => json.encode(toMap());
}
