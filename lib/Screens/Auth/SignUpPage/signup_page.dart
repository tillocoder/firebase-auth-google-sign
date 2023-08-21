import 'package:example_firebase_logical/Screens/Auth/LogInPage/login_page.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/bloc/signup_bloc.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/google_sign/bloc/auth_bloc.dart';
import 'package:example_firebase_logical/Screens/HomePage/home_page.dart';
import 'package:example_firebase_logical/models/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  toolbarHeight: MediaQuery.of(context).size.height * 108 / 800,
                  leading: Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 24, bottom: 39),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffEB0029),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  ),
                  title: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyleText.items(
                            text: 'Sign In',
                            size: 22,
                            color: const Color(0xff020202),
                            fontWeight: FontWeight.w500),
                        StyleText.items(
                            text: 'Register and eat',
                            size: 14,
                            color: const Color(0xff8D92A3),
                            fontWeight: FontWeight.w300),
                      ],
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: media.size.height * 590 / 800,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 26,
                          ),
                          const Center(
                              child: CircleAvatar(
                                  backgroundColor: Colors.grey, maxRadius: 60)),
                          if (state.firebase.isLoading)
                            const CircularProgressIndicator(),
                          if (state.firebase.isError)
                            const Text(
                              'Malumot yetarli emas',
                              style: TextStyle(color: Colors.red),
                            ),
                          StyleText.items(
                              text: 'Full Name',
                              size: 16,
                              color: const Color(
                                0xff020202,
                              ),
                              fontWeight: FontWeight.w400),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter yor full name';
                              }
                            },
                            controller: name,
                            decoration: TextFormFieldsItems.items(
                                text: 'Type your full name'),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          StyleText.items(
                            text: 'Email Address',
                            size: 16,
                            color: const Color(
                              0xff020202,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email address';
                              }
                              return null;
                            },
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: TextFormFieldsItems.items(
                                text: 'Type your email address '),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          StyleText.items(
                            text: 'Password',
                            size: 16,
                            color: const Color(
                              0xff020202,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter yor password';
                              }
                              return null;
                            },
                            controller: password,
                            obscureText: true,
                            decoration: TextFormFieldsItems.items(
                                text: 'Type your password'),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                              style: ElevatedBottomStyle.items(
                                text: '',
                                radius: 8,
                                width: double.infinity,
                                color: const Color(0xffEB0029),
                              ),
                              onPressed: () {
                                context.read<SignupBloc>().add(SignUpEvent(
                                    password: password.text,
                                    email: email.text));
                              },
                              child: const Text('Continue')),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StyleText.items(
                                  text: 'I Already Have an Account', size: 10),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ));
                                },
                                child: StyleText.items(
                                  text: 'Login',
                                  size: 14,
                                  color: const Color(0xffEB0029),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

class TextFormFieldsItems {
  static InputDecoration items({
    required String text,
  }) {
    return InputDecoration(
      hintText: text,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}

class ElevatedBottomStyle {
  static ButtonStyle items(
      {String? text,
      required double radius,
      required double width,
      Color? color}) {
    return ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(width, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ));
  }
}
