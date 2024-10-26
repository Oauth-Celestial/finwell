import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        transactionId: json['transactionId'],
        transactionName: json['transactionName'],
        transactionType: json['transactionType'],
        transactionAmount: json['transactionAmount'],
        transactionDate: (json['transactionDate'] as Timestamp).toDate(),
        transactionCategory: json['transactionCategory']);
  }

  String toJson() => json.encode(toMap());
}
