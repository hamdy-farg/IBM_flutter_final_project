part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInValidState extends SignInState {}

class SignInErrorState extends SignInState {
  final String errorMassge;

  SignInErrorState({required this.errorMassge});
}

class SignInLoadingState extends SignInState {}
