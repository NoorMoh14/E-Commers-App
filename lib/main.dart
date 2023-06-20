import 'package:flutter/material.dart';

import 'Screens/CompleteProfileScreen.dart';
import 'Screens/ForgotPassScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/SignIn.dart';
import 'Screens/Splash.dart';

void main() {
  runApp(const ECommerceApp());
}

class ECommerceApp extends StatelessWidget {
  const ECommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SignInScreen(),
    );
  }
}

