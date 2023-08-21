import 'package:example_firebase_logical/Screens/Auth/SignUpPage/google_sign/bloc/auth_bloc.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/google_sign/bloc/auth_event.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/signup_page.dart';
import 'package:example_firebase_logical/Screens/HomePage/home_page.dart';
import 'package:example_firebase_logical/constants/color.dart';
import 'package:example_firebase_logical/constants/images.dart';
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
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SignIn',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Find your best ever meal',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 60),
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.green,
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        controller: username,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        controller: password,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.background,
                          ),
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  LoginEvents(
                                    email: username.text,
                                    password: password.text,
                                  ),
                                );
                          },
                          child: const Text(
                            'LogIn',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              TextButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (__) => SignupPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              const Text(
                                '- OR Continue with -',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<AuthBloc>().add(
                                            SignInWithGoogleEvent(),
                                          );
                                    },
                                    child: Image.asset(
                                      AppImages.google,
                                      height: 40,
                                      width: 110,
                                    ),
                                  ),
                                  Image.asset(
                                    AppImages.facebook,
                                    height: 45,
                                    width: 110,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Text('Create Account  '),
                                  TextButton(
                                    style: ElevatedButton.styleFrom(),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (__) => SignupPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'SignUp',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
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
