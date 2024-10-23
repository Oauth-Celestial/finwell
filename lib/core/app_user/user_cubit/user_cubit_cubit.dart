import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:finwell/core/app_user/model/app_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'user_cubit_state.dart';

class UserCubitCubit extends Cubit<UserCubitState> {
  UserCubitCubit() : super(UserCubitState.initial());

  Future<bool> getCurrentUser() async {
    emit(state.copyWith(status: UserStatus.loading));
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    AppUserModel userData =
        AppUserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    emit(state.copyWith(userData: userData, status: UserStatus.loggedin));
    return true;
  }
}
