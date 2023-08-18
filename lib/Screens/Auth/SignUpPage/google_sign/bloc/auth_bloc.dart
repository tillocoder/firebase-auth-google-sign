import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<SignInWithGoogleEvent>(_regstrWithGoogle);
  }

  Future<void> _regstrWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    final googleSign = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    try {
      final GoogleSignInAccount? googleUser = await googleSign.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return null;
    } catch (e, s) {
      debugPrint('$e, $s');
      return null;
    }
  }
}
