
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/enum/register_step.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';

class OtpVerificationPage extends ConsumerWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);
    return Column(
      children: [
        if (registerState.step == RegisterStep.phoneNumber) ...[
          TextFormField(
            validator: authNotifier.phoneNumberValidation,
            onChanged: authNotifier.setPhoneNumber,
            keyboardType: TextInputType.number,
            decoration:  const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.secondaryColor, width: 2),
              ),
              hintText: 'Enter your phone number',
            ),
          ),
          Text(
            'A verification code has been sent to ${registerState.phoneNumber}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
24.height,        if (registerState.step == RegisterStep.otpVerification) ...[
          TextFormField(
            onChanged: authNotifier.setOtp,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 6,
            decoration: InputDecoration(
              hintText: 'Enter 6-digit OTP',
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF17387E), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Color(0xFF17387E), width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.length < 6) {
                return "Enter a valid 6-digit code";
              }
              return null;
            },
          ),
        ],
      ],
    );
  }
}
