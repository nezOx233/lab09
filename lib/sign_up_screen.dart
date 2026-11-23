
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'validators.dart';
import 'auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _nameError;
  String? _emailError;
  String? _passwordError;

  bool _isSending = false;

  Future<void> _register() async {
    setState(() {
      _nameError = Validators.requiredField(
        _nameController.text,
        fieldName: 'Імʼя',
      );
      _emailError = Validators.email(_emailController.text);
      _passwordError = Validators.password(_passwordController.text);
    });

    if (_nameError != null || _emailError != null || _passwordError != null) {
      return;
    }

    setState(() => _isSending = true);
    try {
      await ApiService.signUp(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('POST /signup успішно надіслано'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ApiService.errorMessage(error)),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
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

          const AuthHeader(title: 'Sign up'),

          AuthTextField(
            controller: _nameController,
            label: 'Name',
            errorText: _nameError,
            onChanged: () {
              setState(() {
                _nameError = null;
              });
            },
          ),

          AuthTextField(
            controller: _emailController,
            label: 'Email (Login)',
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
            onPressed: _isSending ? null : _register,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
            ),
            child: _isSending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Register'),
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
