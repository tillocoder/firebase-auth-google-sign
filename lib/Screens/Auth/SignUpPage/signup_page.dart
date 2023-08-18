import 'package:example_firebase_logical/Screens/Auth/LogInPage/login_page.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/bloc/signup_bloc.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/google_sign/bloc/auth_bloc.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/google_sign/bloc/auth_event.dart';
import 'package:example_firebase_logical/Screens/HomePage/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    const Text('SIGNUP', style: TextStyle(fontSize: 30)),
                    TextFormField(
                      controller: _username,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _password,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        context.read<SignupBloc>().add(
                              SignUpEvent(
                                email: _username.text,
                                password: _password.text,
                              ),
                            );
                      },
                      child: const Text('SignUp'),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (__) => LoginPage(),
                          ),
                        );
                      },
                      child: const Text('You Have Already Account ?'),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                              SignInWithGoogleEvent(),
                            );
                      },
                      child: Image.asset(
                        'assets/search.png',
                        height: 50,
                        width: 50,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
