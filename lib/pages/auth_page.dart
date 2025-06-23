import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iste_app/pages/homepage.dart';
import 'package:iste_app/pages/loginPage.dart';
import 'package:iste_app/provider/auth_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.isLoggedIn) {
      return const homepage();
    } else {
      return LoginScreen();
    }
  }
}
