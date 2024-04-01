import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());
  // The Folowing Is The Funcation That Handels Login With Email And Password
  // From Firebase...
  Future<void> userSigninWithEmailAndPassword(
      {required email, required password}) async {
    emit(LoginLoadingState());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSucessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          LoginFailureState(errorMessage: 'User Not Found'),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailureState(errorMessage: 'Wrong Password'),
        );
      } else {
        emit(
          LoginFailureState(errorMessage: 'There Was An Error'),
        );
      }
    }
  }
}
