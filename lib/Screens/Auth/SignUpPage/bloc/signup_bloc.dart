import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignUpEvent>(_signUp);
  }
  void _signUp(SignUpEvent event, Emitter<SignupState> emit) {
    emit(state.copyWith(firebase: Status.loading));
    try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
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
