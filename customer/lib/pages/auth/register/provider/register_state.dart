
import 'package:kicksy/pages/auth/register/enum/register_step.dart';

class RegisterState {
  final String name;
  final String email;
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String otp;
  final bool codeSent;
  final String verificationId;
  final bool isLoading;
  final String? errorMessage;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final RegisterStep step;
  final String uid;

  RegisterState({
    this.name = '',
    this.email = '',
    this.phoneNumber = '+91',
    this.password = '',
    this.confirmPassword = '',
    this.codeSent = false,
    this.otp = '',
    this.verificationId = '',
    this.isLoading = false,
    this.errorMessage,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.step = RegisterStep.nameEmail,
    this.uid = '',
  });
  RegisterState copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
    String? verificationId,
    bool? codeSent,
    String? otp,
    bool? isLoading,
    String? errorMessage,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    RegisterStep? step,
    String? uid,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      codeSent: codeSent ?? this.codeSent,
      verificationId: verificationId ?? this.verificationId,
      otp: otp ?? this.otp,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      step: step ?? this.step,
      uid: uid ?? this.uid,
    );
  }
}
