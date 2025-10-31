import 'package:admin/home/pages/home_page.dart';
import 'package:admin/login/pages/login_page.dart';
import 'package:admin/products/pages/products_page.dart';
import 'package:admin/staffs/pages/add_staff_layout.dart';
import 'package:admin/upload/pages/upload_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter route = GoRouter(
  initialLocation: '/login',
  routes: [
    // GoRoute(
    //   path: '/splash',
    //   builder: (contewxt, state) => const SplashScreen(),
    // ),
    GoRoute(path: '/home', builder: (contewxt, state) => const HomePage()),
    GoRoute(
      path: '/add_staff',
      builder: (contewxt, state) => const AddStaffLayout(),
    ),

    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsPage(),
    ),
    GoRoute(path: '/upload', builder: (context, state) => const UploadPage()),
  ],
);
