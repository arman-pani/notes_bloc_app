import 'package:flutter/material.dart';
import 'package:notes_bloc_app/strings.dart' show enterYourEmailHere;

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;
  const PasswordTextField({super.key, required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(hintText: enterYourEmailHere),
    );
  }
}
