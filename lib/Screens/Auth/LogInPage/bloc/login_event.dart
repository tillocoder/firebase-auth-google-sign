part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginEvents extends LoginEvent {
  final String email;
  final String password;

  LoginEvents({required this.email, required this.password});
}
