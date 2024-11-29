part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

abstract class SignInTextChangedEvent extends SignInEvent {
  final String emailValue;
  final String passwordValue;

  SignInTextChangedEvent(
      {required this.emailValue, required this.passwordValue});
}

abstract class SignInSubmitEvent extends SignInEvent {
  final String emailValue;
  final String passwordValue;

  SignInSubmitEvent({required this.emailValue, required this.passwordValue});
}
