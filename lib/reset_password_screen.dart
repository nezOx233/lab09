
import 'package:flutter/material.dart';
import 'api_service.dart';
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

  bool _isSending = false;

  Future<void> _resetPassword() async {
    setState(() {
      _emailError = Validators.email(_emailController.text);
    });

    if (_emailError != null) return;

    setState(() => _isSending = true);
    try {
      await ApiService.resetPassword(email: _emailController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('POST /reset-password успішно надіслано'),
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
            onPressed: _isSending ? null : _resetPassword,
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
                : const Text('Reset password'),
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
