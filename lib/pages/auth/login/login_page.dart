import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';
import 'package:kicksy/widgets/auth_textfield.dart';
import 'package:kicksy/widgets/custom_button.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final registerState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: 16.padAll,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              24.height,
              AuthTextField(
                hintText: 'Enter email id',
                onChanged: authNotifier.setEmail,
                validator: authNotifier.emailValidation,

                prefixIcon: Icons.mail,
              ),
              16.height,
              AuthTextField(
                obscureText: registerState.obscurePassword,
                onChanged: authNotifier.setPassword,
                validator: authNotifier.passwordValidation,
                hintText: "Enter password",
                prefixIcon: Icons.privacy_tip,
                suffixIcon: InkWell(
                  onTap: () => authNotifier.toggleObscurePassword(),

                  child: Icon(
                    registerState.obscurePassword
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                  ),
                ),
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      context.go('/forgot_password');
                    },

                    child: const Text(
                      'Forgot Password',
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              12.height,
              CustomButton(
                isLoading: registerState.isLoading,
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    authNotifier.resetError();
                    await authNotifier.loginUser(context);
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),

              16.height,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an Account ?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
