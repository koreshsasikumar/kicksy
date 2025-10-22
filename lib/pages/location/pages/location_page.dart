import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/pages/location/provider/location_provider.dart';

class LocationPage extends ConsumerWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Location"),
        leading: BackButton(
          onPressed: () {
            context.go('/cart_page');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                location,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(locationProvider.notifier).getCurrentLocation();
                },
                icon: const Icon(Icons.my_location),
                label: const Text("Use My Current Location"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
