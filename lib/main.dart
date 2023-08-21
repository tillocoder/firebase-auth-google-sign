import 'package:example_firebase_logical/Screens/Auth/LogInPage/bloc/login_bloc.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/bloc/signup_bloc.dart';
import 'package:example_firebase_logical/Screens/Auth/SignUpPage/google_sign/bloc/auth_bloc.dart';
import 'package:example_firebase_logical/Screens/HomePage/bloc/home_bloc.dart';
import 'package:example_firebase_logical/main/bloc/main_bloc.dart';
import 'package:example_firebase_logical/splash/bloc/splash_bloc.dart';
import 'package:example_firebase_logical/splash/splash_page.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MainBloc()),
        BlocProvider(create: (_) => HomeBloc()),
        BlocProvider(create: (_) => LoginBloc()),
        BlocProvider(create: (_) => SignupBloc()),
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => SplashBloc())
      ],
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
