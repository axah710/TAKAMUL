// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoadingState());
        try {
          UserCredential user =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
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
      } else if (event is SignupEvent) {
        emit(SignupLoadingState());
        try {
          UserCredential user =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
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
    });
  }
  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    if (kDebugMode) {
      print(transition);
    }
  }
  // This method is called after a transition occurs between states.
  // It logs the transition if the application is running in debug mode.
  // It shows current state , current event and next stat occurred by the event.
}
