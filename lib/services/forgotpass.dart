import 'package:flutter/material.dart';

class ForgotPasswordDialog extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

  ForgotPasswordDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Forgot Password'),
      content: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          labelText: 'Enter your email',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Return the email to the calling code
            Navigator.of(context).pop(_emailController.text);
          },
          child: const Text('Send Reset Email'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
