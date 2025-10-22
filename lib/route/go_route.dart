import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/data/shoe.dart';
import 'package:kicksy/pages/cart/pages/cart_page.dart';
import 'package:kicksy/pages/favourite/favourite_page.dart';
import 'package:kicksy/pages/home/pages/home_page.dart';
import 'package:kicksy/pages/auth/login/forgot_password_page.dart';
import 'package:kicksy/pages/auth/login/login_page.dart';
import 'package:kicksy/pages/auth/register/register_page.dart';
import 'package:kicksy/pages/location/pages/location_page.dart';
import 'package:kicksy/pages/profile_page.dart';
import 'package:kicksy/pages/sneaker_detail/pages/sneaker_details_page.dart';
import 'package:kicksy/sign_out_dialog.dart';
import 'package:kicksy/splash_screen.dart';

final GoRouter route = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (contewxt, state) => const SplashScreen(),
    ),
    GoRoute(path: '/home', builder: (contewxt, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/profile_page',
      builder: (context, state) => const ProfilePage(),
    ),

    GoRoute(
      path: '/sneaker_detail',
      builder: (context, state) {
        final shoe = state.extra as Shoe?;
        return SneakerDetailsPage(shoe: shoe!);
      },
    ),
    GoRoute(
      path: '/location_page',
      builder: (context, state) => const LocationPage(),
    ),

    GoRoute(path: '/cart_page', builder: (context, state) => const CartPage()),
    GoRoute(
      path: '/favourite_page',
      builder: (context, state) => const FavoritesPage(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) {
        final formKey = GlobalKey<FormState>();
        return ForgotPasswordPage(formKey: formKey);
      },
    ),
    GoRoute(
      path: '/sign_out',
      builder: (context, state) => const SignOutDialog(),
    ),
  ],
);
