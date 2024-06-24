import 'package:flutter/material.dart';
import 'package:peerprep2/services/auth_service.dart';

// ignore: must_be_immutable
class SignUpButton extends StatefulWidget {
  bool isLoading;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var usernameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  final  String school;
  SignUpButton({super.key, required this.emailController, required this.passwordController, required this.usernameController, required this.isLoading, required this.school});

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () => AuthService().signUp(
          context, 
          widget.isLoading,
          widget.emailController,
          widget.passwordController,
          widget.usernameController,
          widget.confirmPasswordController,
          widget.school,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12), 
          ),
          child: const Center(
            child: Text(
              'Registrati',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}