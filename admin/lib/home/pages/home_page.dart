import 'package:admin/dashboard/pages/dashboard_page.dart';
import 'package:admin/home/provider/home_page_provider.dart';
import 'package:admin/login/provider/login_provider.dart';
import 'package:admin/orders/pages/orders_page.dart';
import 'package:admin/products/pages/products_page.dart';
import 'package:admin/staffs/pages/staff_page.dart';
import 'package:admin/upload/pages/upload_page.dart';
import 'package:admin/users/pages/users_page.dart';
import 'package:admin/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/appTheme/app_color.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final List<String> menuItems = const [
    'Dashboard',
    'Products',
    'Users',
    'Orders',
    'Upload',
    'Staffs',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(homePageProvider);
    final loginNotifier = ref.watch(loginProvider.notifier);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              ref.read(homePageProvider.notifier).setIndex(index);
            },
            labelType: NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Kicksy Admin',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            destinations: [
              for (var item in menuItems)
                NavigationRailDestination(
                  icon: const Icon(Icons.circle_outlined),
                  selectedIcon: const Icon(Icons.circle),
                  label: Text(item),
                ),
            ],
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: AppColor.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 8,
                        child: Text(
                          menuItems[selectedIndex],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: AssetImage(
                                  'assets/profile.png',
                                ),
                              ),
                            ),
                            Expanded(
                              child: CustomButton(
                                backgroundColor: AppColor.backgroundLight,
                                onPressed: () async {
                                  await loginNotifier.logout();
                                  context.go('/login');
                                },
                                child: Text('Logout'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: Center(
                      key: ValueKey<int>(selectedIndex),
                      child: Builder(
                        builder: (context) {
                          switch (selectedIndex) {
                            case 0:
                              return DashboardPage();
                            case 1:
                              return ProductsPage();
                            case 2:
                              return UsersPage();
                            case 3:
                              return OrdersPage();
                            case 4:
                              return UploadPage();
                            case 5:
                              return StaffsPage();
                            default:
                              return const Text('Welcome');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
