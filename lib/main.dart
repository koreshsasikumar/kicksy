import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/pages/home_page.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();


  runApp(const ProviderScope(child: Kicksy()));
}

class Kicksy extends StatelessWidget {
  const Kicksy({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
