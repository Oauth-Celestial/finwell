import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/dashboard/domain/entities/dashboard_model.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class DashboardDataSource {
  Future<DashboardModel> getDashboardData(String month, String year);
}

class DashboardDataSourceImpl implements DashboardDataSource {
  @override
  Future<DashboardModel> getDashboardData(String month, String year) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot transactionCollectionSnap = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("Transactions")
          .get();

      List<QueryDocumentSnapshot> docs = transactionCollectionSnap.docs;

      List<TransactionModel> transactions = docs.map((doc) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;

        return TransactionModel.fromJson(docData);
      }).toList();

      List<TransactionModel> currentMonthTransactions =
          transactions.where((trans) {
        return trans.transactionMonth?.toLowerCase().trim() == month &&
            trans.transactionYear?.toLowerCase().trim() == year;
      }).toList();

      int incomeThisMonth = 0;
      int expenseThisMonth = 0;

      for (TransactionModel t in currentMonthTransactions) {
        if (t.transactionType.toLowerCase() == "income") {
          incomeThisMonth += t.transactionAmount;
        } else {
          expenseThisMonth += t.transactionAmount;
        }
      }

      return DashboardModel(
          expenseAmount: expenseThisMonth.toString(),
          incomeAmount: incomeThisMonth.toString(),
          recenntTransactions: currentMonthTransactions);
    } catch (e) {
      throw Failure(failureMessage: e.toString());
    }
  }
}
