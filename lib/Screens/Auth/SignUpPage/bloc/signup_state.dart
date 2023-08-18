part of 'signup_bloc.dart';

class SignupState extends Equatable {
  final Status firebase;

  const SignupState({this.firebase = Status.initial});
  SignupState copyWith({Status? firebase}) {
    return SignupState(firebase: firebase ?? this.firebase);
  }

  @override
  List<Object?> get props => [firebase];
}
