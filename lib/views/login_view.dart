import 'package:flutter/cupertino.dart';
import 'package:notes_bloc_app/views/email_text_field.dart';
import 'package:notes_bloc_app/views/login_button.dart';
import 'package:notes_bloc_app/views/password_text_field.dart';

class LoginView extends StatelessWidget {
  final OnLoginTapped onLoginTapped;
  const LoginView({super.key, required this.onLoginTapped});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          PasswordTextField(passwordController: passwordController),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
