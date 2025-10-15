import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/enum/register_step.dart';
import 'package:kicksy/pages/auth/register/otp_verification_page.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';
import 'package:kicksy/widgets/auth_textfield.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authNotifier = ref.read(authProvider.notifier);
      authNotifier.resetRegistration();
    });
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Container(
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
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  registerState.codeSent ? "Verify OTP" : "Sign Up",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: AppColor.backgroundLight,
                  ),
                ),
                32.height,
                if (registerState.errorMessage != null)
                  Padding(
                    padding: EdgeInsetsGeometry.only(bottom: 16),
                    child: Text(
                      registerState.errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (registerState.step == RegisterStep.nameEmail) ...[
                  AuthTextField(
                    prefixIcon: Icons.person,
                    hintText: 'Enter your name',
                    validator: authNotifier.nameValidation,
                    onChanged: authNotifier.setName,
                  ),
                  16.height,
                  AuthTextField(
                    prefixIcon: Icons.mail,
                    validator: authNotifier.emailValidation,
                    onChanged: authNotifier.setEmail,

                    hintText: 'Enter your email id',
                  ),
                ],
                16.height,
                OtpVerificationPage(),

                16.height,
                if (registerState.step == RegisterStep.passwordSetup) ...[
                  AuthTextField(
                    obscureText: registerState.obscurePassword,
                    validator: authNotifier.passwordValidation,
                    onChanged: authNotifier.setPassword,
                    hintText: 'Enter your Password',
                  ),
                  16.height,

                  AuthTextField(
                    hintText: 'Enter confirm password',
                    obscureText: registerState.obscureConfirmPassword,
                    validator: authNotifier.confirmPasswordValidation,
                    onChanged: authNotifier.setConfirmPassword,
                  ),
                ],
                24.height,
                ElevatedButton(
                  onPressed: registerState.isLoading
                      ? null
                      : () async {
                          if (!formKey.currentState!.validate()) return;
                          authNotifier.resetError();
                          await authNotifier.registerFlow(context: context);
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFF17387E),
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  child: registerState.isLoading
                      ? CircularProgressIndicator(color: Colors.blue)
                      : Text(
                          authNotifier.getButtonText(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                ),
                20.height,
                if (registerState.step == RegisterStep.nameEmail)
                  TextButton(
                    onPressed: () => context.go('/login'),

                    child: Text(
                      'Already have an account',
                      style: TextStyle(color: Color(0xFF17387E)),
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
