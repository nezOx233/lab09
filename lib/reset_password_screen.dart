
import 'package:flutter/material.dart';
import 'validators.dart';
import 'auth_widgets.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final _emailController = TextEditingController();

  String? _emailError;

  void _resetPassword() {
    setState(() {
      _emailError = Validators.email(
        _emailController.text,
      );
    });

    if (_emailError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Email правильний.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 65),

          const AuthHeader(
            title: 'Reset password',
          ),

          const Text(
            'Enter your email to reset your password',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),

          const SizedBox(height: 25),

          AuthTextField(
            controller: _emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            errorText: _emailError,
            onChanged: () {
              setState(() {
                _emailError = null;
              });
            },
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _resetPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text('Reset password'),
          ),

          const SizedBox(height: 12),

          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Back to login'),
          ),
        ],
      ),
    );
  }
}
