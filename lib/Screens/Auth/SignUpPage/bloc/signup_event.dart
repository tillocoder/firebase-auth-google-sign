part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignUpEvent extends SignupEvent {
  final String email;
  final String password;

  SignUpEvent({required this.email, required this.password});
}
