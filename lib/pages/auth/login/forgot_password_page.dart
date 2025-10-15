
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';
import 'package:kicksy/widgets/auth_textfield.dart';
import 'package:kicksy/widgets/custom_button.dart';

class ForgotPasswordPage extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  const ForgotPasswordPage({super.key, required this.formKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Forgot Password',
              style: TextStyle(
                color: Color(0xFF17387E),
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Sign in with your email instead no password needed!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            12.height,
            AuthTextField(
              prefixIcon: Icons.mail,
              onChanged: authNotifier.setEmail,
              validator: authNotifier.emailValidation,
              hintText: 'Enter your email',
            ),
            20.height,
            CustomButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  await authNotifier.resetPassword(
                    registerState.email,
                    context,
                  );
                }
              },
              isLoading: registerState.isLoading,
              child: Text("Continue", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
