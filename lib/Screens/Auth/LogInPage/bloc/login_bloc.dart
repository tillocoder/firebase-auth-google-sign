// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginEvents>(_login);
  }
  void _login(LoginEvents event, Emitter<LoginState> emit) {
    emit(state.copyWith(firebase: Status.loading));
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(firebase: Status.succes));
    } on FirebaseAuthException catch (e) {
      print('error ${e.code}');
      emit(state.copyWith(firebase: Status.error));
    }
  }
}

enum Status { initial, loading, succes, error }

extension FireebaseStatusX on Status {
  bool get isInitial => this == Status.initial;

  bool get isLoading => this == Status.loading;

  bool get isSuccess => this == Status.succes;

  bool get isError => this == Status.error;
}
