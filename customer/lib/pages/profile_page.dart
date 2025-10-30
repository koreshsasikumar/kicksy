import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';
import 'package:kicksy/sign_out_dialog.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final registerState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/home')),
        title: Text(
          'Profile',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: 16.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(registerState.email, style: theme.textTheme.bodyMedium),
            Expanded(
              child: ListView(
                padding: 20.padLeft,
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.home_outlined,
                      size: 20,
                      color: AppColor.backgroundDark,
                    ),
                    title: Text(
                      'Home',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.backgroundDark,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_outlined,
                      size: 20,
                      color: AppColor.backgroundDark,
                    ),
                    title: Text(
                      'Setting',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.backgroundDark,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.adobe_outlined,
                      size: 20,
                      color: AppColor.backgroundDark,
                    ),
                    title: Text(
                      'About App',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.backgroundDark,
                      ),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_outlined, size: 20),
                    title: Text(
                      'Sign Out',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => const SignOutDialog(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
