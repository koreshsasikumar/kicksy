import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/appTheme/app_theme.dart';
import 'package:kicksy/firebase_options.dart';
import 'package:kicksy/route/go_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(    options: DefaultFirebaseOptions.currentPlatform,
);

  runApp(const ProviderScope(child: Kicksy()));
}

class Kicksy extends StatelessWidget {
  const Kicksy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Do Daily',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: route,
    );
  }
}
