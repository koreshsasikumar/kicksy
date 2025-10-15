import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
    final registerState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Form(
        key: formKey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0A2472),
                Color(0xFF1A3B8F),
                Color(0xFF2B529D),
                Color(0xFF3C6AB2),
                Color(0xFF4D81C8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: 16.padAll,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.white,
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
                      color: Color(0xFF17387E),
                      registerState.obscurePassword
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        context.go('/forgot_password');
                      },

                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: const Color(0xFF17387E),
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
                  child: Text(
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
                          color: Color(0xFF17387E),
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
      ),
    );
  }
}
