import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransactionModel {
  String transactionId;
  String transactionName;
  String transactionType;
  int transactionAmount;
  String transactionCategory;
  DateTime transactionDate;
  String? transactionMonth;
  String? transactionYear;
  TransactionModel(
      {this.transactionId = "",
      required this.transactionName,
      required this.transactionType,
      required this.transactionAmount,
      required this.transactionDate,
      required this.transactionCategory,
      this.transactionMonth,
      this.transactionYear});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transactionId': transactionId,
      'transactionName': transactionName.trim(),
      'transactionType': transactionType.toLowerCase().trim(),
      'transactionAmount': transactionAmount,
      'transactionCategory': transactionCategory.toLowerCase().trim(),
      'transactionDate': transactionDate,
      'transactionMonth': transactionDate.monthName.toLowerCase().trim(),
      'transactionFormatedDate': transactionDate.toCustomFormattedString(),
      'transactionYear': transactionDate.year.toString().trim()
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
        transactionId: json['transactionId'],
        transactionName: json['transactionName'],
        transactionType: json['transactionType'],
        transactionAmount: json['transactionAmount'],
        transactionMonth: json['transactionMonth'],
        transactionYear: json['transactionYear'],
        transactionDate: (json['transactionDate'] as Timestamp).toDate(),
        transactionCategory: json['transactionCategory']);
  }

  String toJson() => json.encode(toMap());
}
