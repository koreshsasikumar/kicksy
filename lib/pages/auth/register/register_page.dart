import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/enum/register_step.dart';
import 'package:kicksy/pages/auth/register/otp_verification_page.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';
import 'package:kicksy/widgets/auth_textfield.dart';
import 'package:kicksy/widgets/custom_button.dart';

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
    final theme = Theme.of(context);
    final registerState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      body: Padding(
        padding: 16.padAll,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                registerState.codeSent ? "Verify OTP" : "Sign Up",
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  
                ),
               
              ),
              32.height,
              if (registerState.errorMessage != null)
                Padding(
                  padding: const EdgeInsetsGeometry.only(bottom: 16),
                  child: Text(
                    registerState.errorMessage!,
                    style: const TextStyle(
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
              const OtpVerificationPage(),

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
              CustomButton(
                onPressed: registerState.isLoading
                    ? null
                    : () async {
                        if (!formKey.currentState!.validate()) return;
                        authNotifier.resetError();
                        await authNotifier.registerFlow(context: context);
                      },
                isLoading: registerState.isLoading,
                child: registerState.isLoading
                    ? const CircularProgressIndicator(color: Colors.blue)
                    : Text(
                        authNotifier.getButtonText(),
                        style: const TextStyle(
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
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: AppColor.secondaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
