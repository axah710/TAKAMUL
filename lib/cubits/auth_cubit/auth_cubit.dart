import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
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

  Future<void> userSignupWithEmailAndPassword(
      {required email, required password}) async {
    emit(SignupLoadingState());
    try {
      // ignore: unused_local_variable
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      emit(
        SignupSucessState(
            sucessMessage: 'The account has been created successfully.'),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          SignupFailureState(
              errorMessage: "The password provided is too weak."),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          SignupFailureState(
              errorMessage: "The account already exists for that email."),
        );
      } else {
        emit(
          SignupFailureState(errorMessage: "Oops there was an error."),
        );
      }
    }
  }
}
