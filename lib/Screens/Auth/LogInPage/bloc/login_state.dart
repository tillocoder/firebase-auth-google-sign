part of 'login_bloc.dart';

class LoginState extends Equatable {
  final Status firebase;

  LoginState({this.firebase = Status.initial});
  LoginState copyWith({Status? firebase}) {
    return LoginState(firebase: firebase ?? this.firebase);
  }

  @override
  List<Object?> get props => [firebase];
}
