part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginInitialState extends AuthState {}
// This is the Login initial state ...

final class LoginSucessState extends AuthState {}

final class LoginLoadingState extends AuthState {}

final class LoginFailureState extends AuthState {
  final String errorMessage;

  LoginFailureState({required this.errorMessage});
}

final class SignupInitial extends AuthState {}
// This is the Signup initial state ...

final class SignupSucessState extends AuthState {
  final String sucessMessage;

  SignupSucessState({required this.sucessMessage});
}

final class SignupLoadingState extends AuthState {}

final class SignupFailureState extends AuthState {
  final String errorMessage;

  SignupFailureState({required this.errorMessage});
}
