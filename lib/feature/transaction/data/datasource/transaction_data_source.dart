import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/core/extensions/ext_date_time.dart';
import 'package:finwell/feature/transaction/domain/entities/transaction_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class TransactionDataSource {
  Future<TransactionModel> createTransaction(TransactionModel transactionData);
  Future<List<TransactionModel>> fetchTransaction(String transactionDate);
}

class TransactionDataSourceImpl implements TransactionDataSource {
  @override
  Future<TransactionModel> createTransaction(
      TransactionModel transactionData) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;

    try {
      String transactionDate =
          transactionData.transactionDate.toCustomFormattedString();
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection(transactionDate)
          .doc(transactionData.transactionId)
          .set(transactionData.toMap());
      return transactionData;
    } catch (e) {
      throw Failure(failureMessage: e.toString());
    }
  }

  @override
  Future<List<TransactionModel>> fetchTransaction(
      String transactionDate) async {
    // TODO: implement fetchTransaction
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      QuerySnapshot transactionCollectionSnap = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection(transactionDate)
          .get();

      List<QueryDocumentSnapshot> docs = transactionCollectionSnap.docs;

      List<TransactionModel> transactions = docs.map((doc) {
        Map<String, dynamic> docData = doc.data() as Map<String, dynamic>;

        return TransactionModel.fromJson(docData);
      }).toList();
      return transactions;
    } catch (e) {
      throw Failure(failureMessage: e.toString());
    }
  }
}
