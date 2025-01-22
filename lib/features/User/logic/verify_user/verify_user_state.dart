part of 'verify_user_cubit.dart';

@immutable
sealed class VerifyUserState {
  const VerifyUserState();
}

final class VerifyUserInitial extends VerifyUserState {}

final class VerifyUserSuccess extends VerifyUserState {}

final class VerifyUserFial extends VerifyUserState {
  final String message;
  const VerifyUserFial({required this.message});
}

final class VerifyUserLoading extends VerifyUserState {}
