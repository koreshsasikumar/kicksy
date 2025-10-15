
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';

class SignOutDialog extends ConsumerWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authNotifier = ref.read(authProvider.notifier);
    return AlertDialog(
      title: Column(
        children: [
          Image(
            image: AssetImage('assets/images/logout.png'),
            width: 80,
            height: 80,
          ),
          20.height,
          Text(
            "Logging out will pause your progress...  Are you sure?",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text("Nah, Just Kidding"),
            ),
          ),
          8.height,
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  authNotifier.logout(context);
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.red),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                textStyle: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text("Yes, Log Me Out"),
            ),
          ),
        ],
      ),
    );
  }
}
