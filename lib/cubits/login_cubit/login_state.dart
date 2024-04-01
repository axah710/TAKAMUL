part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitialState extends LoginState {}
// This is the initial state ...

final class LoginSucessState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginFailureState extends LoginState {
  final String errorMessage;

  LoginFailureState({required this.errorMessage});
}
