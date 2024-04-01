import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
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
