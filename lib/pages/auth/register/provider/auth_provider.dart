import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/pages/auth/register/enum/register_step.dart';
import 'package:kicksy/pages/auth/register/provider/register_state.dart';

final authProvider = StateNotifierProvider<AuthProvider, RegisterState>((ref) {
  final resetEmailController = TextEditingController();
  return AuthProvider(resetEmailController);
});

class AuthProvider extends StateNotifier<RegisterState> {
  AuthProvider(this.resetEmailController) : super(RegisterState()) {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      state = state.copyWith(
        name: currentUser.displayName ?? '',
        email: currentUser.email ?? '',
      );
    }
  }

  final TextEditingController resetEmailController;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  void setName(String name) =>
      state = state.copyWith(name: name.trim(), errorMessage: null);

  void setEmail(String email) =>
      state = state.copyWith(email: email.trim(), errorMessage: null);

  void setPhoneNumber(String phone) {
    String formatted = phone.trim();
    if (!formatted.startsWith('+')) {
      formatted = '+91$formatted';
    }
    state = state.copyWith(phoneNumber: formatted, errorMessage: null);
  }

  void setOtp(String otp) =>
      state = state.copyWith(otp: otp.trim(), errorMessage: null);

  void codeSent(String verificationId, int? resendToken) {
    debugPrint(
      'Code sent to ${state.phoneNumber}.verification ID:$verificationId',
    );
    state = state.copyWith(
      step: RegisterStep.otpVerification,
      verificationId: verificationId,
      codeSent: true,
      isLoading: false,
      errorMessage: null,
    );
  }

  String getButtonText() {
    if (state.step == RegisterStep.nameEmail) {
      return 'Next';
    } else if (state.step == RegisterStep.phoneNumber) {
      return 'Send OTP';
    } else if (state.step == RegisterStep.otpVerification) {
      return 'Verify OTP';
    } else if (state.step == RegisterStep.passwordSetup) {
      return 'Next';
    }
    return 'Next';
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    debugPrint('Auto retrieval timeout. Verification ID: $verificationId');
    state = state.copyWith(verificationId: verificationId, isLoading: false);
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    debugPrint('Auto verification completed');
    state = state.copyWith(isLoading: false);
  }

  void verificationFailed(FirebaseAuthException e) {
    debugPrint("Verification failed: ${e.message}");
    state = state.copyWith(isLoading: false, errorMessage: e.message);
  }

  void setPassword(String password) =>
      state = state.copyWith(password: password.trim(), errorMessage: null);

  void setConfirmPassword(String confirmPassword) => state = state.copyWith(
    confirmPassword: confirmPassword.trim(),
    errorMessage: null,
  );

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+(com|net|org)$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }

    return null;
  }

  String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone Number is required";
    }
    String cleaned = value.replaceAll(RegExp(r'[\s-]'), '');
    if (cleaned.startsWith('+91')) {
      cleaned = cleaned.substring(3);
    }
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 10) {
      return "Enter a valid phone number (10 digits)";
    }
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
      return "Enter a valid phone number (min 10 digits)";
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters";
    }
    return null;
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Confirm Password is required";
    }
    if (state.password != value) {
      return "Password does not match";
    }
    return null;
  }

  Future<bool> registerFlow({required BuildContext context}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      switch (state.step) {
        case RegisterStep.nameEmail:
          state = state.copyWith(
            step: RegisterStep.phoneNumber,
            isLoading: false,
          );
          return true;

        case RegisterStep.phoneNumber:
          await auth.verifyPhoneNumber(
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: (verificationId, resendToken) =>
                codeSent(verificationId, resendToken),
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            phoneNumber: state.phoneNumber,
          );
          return true;

        case RegisterStep.otpVerification:
          if (state.otp.isEmpty || state.verificationId.isEmpty) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: 'Please enter OTP',
            );
            return false;
          }

          final credential = PhoneAuthProvider.credential(
            verificationId: state.verificationId,
            smsCode: state.otp,
          );
          final userCredential = await auth.signInWithCredential(credential);
          final user = userCredential.user!;

          if (state.name.isNotEmpty) await user.updateDisplayName(state.name);

          await fireStore.collection("users").doc(user.uid).set({
            "uid": user.uid,
            "name": state.name,
            "phoneNumber": state.phoneNumber,
            "createdAt": DateTime.now(),
          }, SetOptions(merge: true));

          state = state.copyWith(
            step: RegisterStep.passwordSetup,
            isLoading: false,
            otp: '',
            verificationId: '',
            codeSent: false,
          );
          return true;

        case RegisterStep.passwordSetup:
          final user = auth.currentUser;
          if (user == null) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: "No user found",
            );
            return false;
          }

          if (state.email.isNotEmpty && state.password.isNotEmpty) {
            await user.linkWithCredential(
              EmailAuthProvider.credential(
                email: state.email,
                password: state.password,
              ),
            );
          }

          await fireStore.collection("users").doc(user.uid).set({
            "email": state.email,
          }, SetOptions(merge: true));

          state = state.copyWith(isLoading: false);

          if (context.mounted) {
            context.go('/home');
          }

          return true;
      }
    } catch (e) {
      debugPrint("Error in registration flow: $e");
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Something went wrong',
      );
      return false;
    }
  }

  Future<bool> loginUser(BuildContext context) async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final userCredential = await auth.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );

      final user = userCredential.user!;
      String finalName = user.displayName ?? '';

      try {
        final doc = await fireStore.collection("users").doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data();
          finalName = data?['name'] as String? ?? finalName;
        }
      } catch (e) {
        debugPrint("Error fetching user data from Firestore: $e");
      }

      state = state.copyWith(
        isLoading: false,
        errorMessage: null,
        name: finalName,
        email: user.email,
      );

      if (context.mounted) {
        context.go('/home');
      }

      return true;
    } on FirebaseAuthException catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint("FirebaseAuthException: code=${e.code}, message=${e.message}");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
      return false;
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      debugPrint("Password reset mail has been sent to$email");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password reset email sent!")),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint("Error:${e.message}");
    }
  }

  void resetError() {
    state = state.copyWith(errorMessage: null);
  }

  void resetRegistration() {
    state = RegisterState();
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    state = RegisterState();

    if (context.mounted) {
      context.go('/login');

      state = state.copyWith(errorMessage: null);
    }
  }

  void toggleObscurePassword() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void toggleObscureConfirmPassword() {
    state = state.copyWith(
      obscureConfirmPassword: !state.obscureConfirmPassword,
    );
  }
}
