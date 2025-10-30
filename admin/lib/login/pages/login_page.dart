import 'package:admin/appTheme/app_color.dart';
import 'package:admin/extension/extension.dart';
import 'package:admin/login/provider/login_provider.dart';
import 'package:admin/widgets/auth_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final loginState = ref.watch(loginProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final provider = ref.watch(loginProvider.notifier);

    return Scaffold(
      backgroundColor: Color(0xFF43A047),
      body: Center(
        child: Container(
          width: screenWidth > 600 ? 420 : screenWidth * 0.9,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  size: 60,
                  color: Color(0xFF43A047),
                ),
                16.height,
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                32.height,
                AuthTextField(
                  controller: provider.emailController,
                  hintText: 'Email',
                  validator: provider.emailValidation,
                ),
                20.height,
                AuthTextField(
                  controller: provider.passwordController,
                  hintText: 'Password',
                  validator: provider.passwordValidation,
                ),
                30.height,
                loginState.isLoading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF43A047),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 5,
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await provider.login(
                                context,
                                provider.emailController.text,
                                provider.passwordController.text,
                              );
                              final user = ref.read(loginProvider).value;
                              if (user != null && context.mounted) {
                                context.go('/home');
                              }
                            }
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColor.backgroundLight,
                            ),
                          ),
                        ),
                      ),

                16.height,
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xFF43A047)),
                  ),
                ),
                if (loginState.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      loginState.error.toString(),
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
