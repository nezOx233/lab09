
import 'package:flutter/material.dart';
import 'validators.dart';
import 'auth_widgets.dart';
import 'sign_up_screen.dart';
import 'reset_password_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _login() {
    setState(() {
      _emailError = Validators.email(
        _emailController.text,
      );

      _passwordError = Validators.password(
        _passwordController.text,
      );
    });

    if (_emailError == null && _passwordError == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Дані правильні.',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthPage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 65),

          const AuthHeader(title: 'Sign in'),

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

          AuthTextField(
            controller: _passwordController,
            label: 'Password',
            obscureText: true,
            errorText: _passwordError,
            onChanged: () {
              setState(() {
                _passwordError = null;
              });
            },
          ),

          const SizedBox(height: 10),

          ElevatedButton(
            onPressed: _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            child: const Text('Login'),
          ),

          const SizedBox(height: 12),

          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const SignUpScreen(),
                ),
              );
            },
            child: const Text('Sign up'),
          ),

          const SizedBox(height: 12),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                  const ResetPasswordScreen(),
                ),
              );
            },
            child: const Text('Forgot password?'),
          ),
        ],
      ),
    );
  }
}
