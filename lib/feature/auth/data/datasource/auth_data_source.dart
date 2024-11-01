import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:finwell/core/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthDataSource {
  Future<User> loginWithGoogle();
  Future<AppUserModel> createUser({required User user});
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
  Future<AppUserModel> createUser({required User user}) async {
    try {
      String authId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("Users")
          .doc(authId)
          .get();
      if (userDoc.exists) {
        AppUserModel userData =
            AppUserModel.fromMap(userDoc.data() as Map<String, dynamic>);
        return userData.copyWith(alreadyUser: true);
      } else {
        try {
          String? deviceToken = await FirebaseMessaging.instance.getToken();
          Map<String, dynamic> userData = {
            "userId": user.uid,
            "name": user.displayName,
            "email": user.email,
            "monthly_income": 0,
            "monthly_spend": 0,
            "joined_on": DateTime.now(),
            "last_used": DateTime.now(),
            "deviceToken": deviceToken
          };
          await FirebaseFirestore.instance
              .collection("Users")
              .doc(authId)
              .set(userData);
          return AppUserModel.fromMap(userData);
        } catch (e) {
          throw (Failure(failureMessage: "User Creation Failed"));
        }
      }
    } catch (e) {
      throw (Failure(failureMessage: "User Creation Failed"));
    }
  }
}
