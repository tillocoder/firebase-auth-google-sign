import 'package:example_firebase_logical/Screens/Auth/SignUpPage/signup_page.dart';
import 'package:example_firebase_logical/Screens/HomePage/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return StreamBuilder<User?>(
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
                      const Text('LOGIN', style: TextStyle(fontSize: 30)),
                      TextFormField(
                        controller: username,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: password,
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LoginBloc>().add(
                                LoginEvents(
                                  email: username.text,
                                  password: password.text,
                                ),
                              );
                        },
                        child: const Text('LogIn'),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (__) => SignUpPage(),
                            ),
                          );
                        },
                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
