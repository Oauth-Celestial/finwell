import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppUserModel {
  String userName;
  String email;
  String uuid;
  int monthlyIncome;
  int monthlyExpense;
  bool alreadyUser;
  DateTime? joinedOn;
  AppUserModel(
      {required this.userName,
      required this.email,
      required this.uuid,
      required this.monthlyIncome,
      required this.monthlyExpense,
      this.joinedOn,
      this.alreadyUser = false});

  AppUserModel copyWith(
      {String? userName,
      String? email,
      String? uuid,
      int? monthlyIncome,
      int? monthlyExpense,
      bool? alreadyUser}) {
    return AppUserModel(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        uuid: uuid ?? this.uuid,
        monthlyIncome: monthlyIncome ?? this.monthlyIncome,
        monthlyExpense: monthlyExpense ?? this.monthlyExpense,
        alreadyUser: alreadyUser ?? this.alreadyUser);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'email': email,
      'uuid': uuid,
      'monthlyIncome': monthlyIncome,
      'monthlyExpense': monthlyExpense,
    };
  }

  factory AppUserModel.fromMap(Map<String, dynamic> map) {
    return AppUserModel(
        userName: map["name"] as String,
        email: map['email'] as String,
        uuid: map["userId"] as String,
        monthlyIncome: map["monthly_income"] as int,
        monthlyExpense: map["monthly_spend"] as int,
        joinedOn: (map['joined_on'] is Timestamp)
            ? (map['joined_on'] as Timestamp).toDate()
            : map['joined_on']);
  }

  String toJson() => json.encode(toMap());

  factory AppUserModel.fromJson(String source) =>
      AppUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
