import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/auth_screen.dart';
import 'package:myapp/screens/init_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        // User is logged in, navigate to MainScreen
        Get.offAll(() => MainScreen());
      } else {
        // User is not logged in, navigate to AuthScreen
        Get.offAll(() => const AuthScreen());
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
