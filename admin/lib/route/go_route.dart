import 'package:admin/home/pages/home_page.dart';
import 'package:admin/login/pages/login_page.dart';
import 'package:admin/products/pages/products_page.dart';
import 'package:admin/upload/pages/upload_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter route = GoRouter(
  initialLocation: '/home',
  routes: [
    // GoRoute(
    //   path: '/splash',
    //   builder: (contewxt, state) => const SplashScreen(),
    // ),
    GoRoute(path: '/home', builder: (contewxt, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsPage(),
    ),
    GoRoute(path: '/upload', builder: (context, state) => const UploadPage()),
  ],
);
