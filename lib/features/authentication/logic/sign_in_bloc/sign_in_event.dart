part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

abstract class SignInTextChangedEvent extends SignInEvent {
  final String emailValue;
  final String oasswordValue;

  SignInTextChangedEvent(
      {required this.emailValue, required this.oasswordValue});
}

abstract class SignInSubmitEvent extends SignInEvent {
  final String emailValue;
  final String oasswordValue;

  SignInSubmitEvent({required this.emailValue, required this.oasswordValue});
}
