import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:finwell/feature/onboarding/domain/entities/onboarding_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class OnboardingDatasource {
  Future<bool> updateUser(OnboardingModel user);
}

class OnboardingDatasourceImpl implements OnboardingDatasource {
  @override
  Future<bool> updateUser(OnboardingModel user) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "name": user.name,
        "monthly_income": user.montlyIncome,
        "monthly_spend": user.monthlyExpense,
        "joined_on": DateTime.now(),
        "last_used": DateTime.now()
      });
      return true;
    } catch (e) {
      throw (Failure(failureMessage: "Updated Failed"));
    }
  }
}
