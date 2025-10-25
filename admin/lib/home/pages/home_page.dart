import 'package:admin/dashboard/pages/dashboard_page.dart';
import 'package:admin/home/provider/home_page_provider.dart';
import 'package:admin/orders/pages/orders_page.dart';
import 'package:admin/products/pages/products_page.dart';
import 'package:admin/upload/pages/upload_page.dart';
import 'package:admin/users/pages/users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:admin/appTheme/app_color.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final List<String> menuItems = const [
    'Dashboard',
    'Products',
    'Users',
    'Orders',
    'Upload',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(homePageProvider);

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
                      Text(
                        menuItems[selectedIndex],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage('assets/profile.png'),
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
