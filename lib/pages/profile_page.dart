import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/sign_out_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/home')),
        title: Text('Profile', style: theme.textTheme.bodyLarge),
      ),
      body: Padding(
        padding: 16.padAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: 20.padLeft,
                children: [
                  ListTile(
                    leading: Icon(
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
                    leading: Icon(
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
                    leading: Icon(
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
                    leading: Icon(
                      Icons.logout_outlined,
                      size: 20,
                      // color: Colors.white,
                    ),
                    title: Text(
                      'Sign Out',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => SignOutDialog(),
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
