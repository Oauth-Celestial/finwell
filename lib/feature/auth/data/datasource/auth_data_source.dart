import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthDataSource {
  Future<User> loginWithGoogle();
  Future<bool> createUser({required User user});
}

class AuthDataSourceImpl implements AuthDataSource {
  @override
  Future<User> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        return currentUser;
      } else {
        throw (Failure(failureMessage: "Something Went Wrong"));
      }
    } catch (e) {
      throw (Failure(failureMessage: "Something Went Wrong"));
    }
  }

  @override
  Future<bool> createUser({required User user}) async {
    try {
      String authId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(authId)
          .get();
      if (userDoc.exists) {
        return true;
      } else {
        try {
          await FirebaseFirestore.instance.collection("Users").doc(authId).set({
            "userId": user.uid,
            "name": user.displayName,
            "email": user.email,
            "monthly_income": 0,
            "monthly_spend": 0,
            "joined_on": DateTime.now(),
            "last_used": DateTime.now()
          });
          return true;
        } catch (e) {
          throw (Failure(failureMessage: "User Creation Failed"));
        }
      }
    } catch (e) {
      throw (Failure(failureMessage: "User Creation Failed"));
    }
  }
}
