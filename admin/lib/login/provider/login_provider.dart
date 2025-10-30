import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final loginProvider = StateNotifierProvider<LoginProvider, AsyncValue<User?>>((
  ref,
) {
  return LoginProvider();
});

class LoginProvider extends StateNotifier<AsyncValue<User?>> {
  LoginProvider() : super(const AsyncValue.data(null));

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    return null;
  }

  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  Future<void> makeAdmin(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('You must be logged in as an admin to assign roles.');
      return;
    }

    final callable = FirebaseFunctions.instance.httpsCallable('setAdminRole');
    try {
      final result = await callable.call({'email': email});
      print(result.data['message']);
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final idTokenResult = await credential.user!.getIdTokenResult();
      final claims = idTokenResult.claims;

      if (claims?['admin'] == true) {
        state = AsyncValue.data(credential.user);
        debugPrint('Admin login successful');
      } else {
        await auth.signOut();

        state = AsyncValue.error(
          'Access denied. You are not an Admin',

          StackTrace.current,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Access Denied: Admins only')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No account found for that email.';
          break;
        case 'wrong-password':
          message = 'Incorrect password. Please try again.';
          break;
        case 'invalid-email':
          message = 'Invalid email format.';
          break;
        case 'user-disabled':
          message = 'This account has been disabled.';
          break;
        default:
          message = 'Login failed. Please check your credentials.';
      }

      state = AsyncValue.error(message, StackTrace.current);
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    emailController.clear();
    passwordController.clear();
    state = const AsyncValue.data(null);
  }
}
