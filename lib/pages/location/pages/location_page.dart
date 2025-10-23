import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/location/provider/location_provider.dart';
import 'package:kicksy/widgets/custom_button.dart';
import 'package:kicksy/widgets/custom_textfield.dart';

class LocationPage extends ConsumerWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final location = ref.watch(locationProvider);
    final locationNotifier = ref.read(locationProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Location",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        leading: BackButton(
          onPressed: () {
            context.go('/cart_page');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: 16.padAll,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  location.fullAddress,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    ref.read(locationProvider.notifier).getCurrentLocation();
                  },
                  icon: const Icon(Icons.my_location),
                  label: const Text("Use My Current Location"),
                ),
                8.height,
                CustomTextfield(
                  controller: locationNotifier.houseNoController,
                  hintText: 'Enter House No., Building Name',
                  onChanged: (value) {
                    locationNotifier.setHouseNo(value);
                  },
                ),
                8.height,
                CustomTextfield(
                  controller: locationNotifier.cityController,
                  hintText: 'Enter city',
                  onChanged: (value) {
                    locationNotifier.setCity(value);
                  },
                ),
                8.height,
                CustomTextfield(
                  controller: locationNotifier.stateController,
                  hintText: 'Enter state',
                  onChanged: (value) {
                    locationNotifier.setState(value);
                  },
                ),
                8.height,
                CustomTextfield(
                  controller: locationNotifier.pinCodeController,
                  hintText: 'Enter Pin Code',
                  onChanged: (value) {
                    locationNotifier.setPinCode(value);
                  },
                ),
                12.height,
                SizedBox(
                  width: 200,
                  child: CustomButton(
                    onPressed: () async {
                      await locationNotifier.submitLocation();
                      if (context.mounted) {
                        context.go('/cart_page');
                      }
                    },
                    isLoading: locationNotifier.isLoading,
                    child: Text(
                      'Submit',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
