import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/data/shoe.dart';
import 'package:kicksy/pages/home_page.dart';
import 'package:kicksy/pages/auth/login/forgot_password_page.dart';
import 'package:kicksy/pages/auth/login/login_page.dart';
import 'package:kicksy/pages/auth/register/register_page.dart';
import 'package:kicksy/pages/profile_page.dart';
import 'package:kicksy/pages/sneaker_details_page.dart';
import 'package:kicksy/sign_out_dialog.dart';
import 'package:kicksy/splash_screen.dart';

final GoRouter route = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (contewxt, state) => SplashScreen()),
    GoRoute(path: '/home', builder: (contewxt, state) => HomePage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(path: '/profile_page', builder: (context, state) => ProfilePage()),

    GoRoute(
      path: '/sneaker_detail',
      builder: (context, state) => SneakerDetailsPage(shoe: shoes.first),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) {
        final formKey = GlobalKey<FormState>();
        return ForgotPasswordPage(formKey: formKey);
      },
    ),
    GoRoute(path: '/sign_out', builder: (context, state) => SignOutDialog()),
  ],
);
