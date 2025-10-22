import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, String>((ref) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<String> {
  LocationNotifier() : super("Use current location");

  bool isLoading = false;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      state = "Please enable location services and try again.";
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = "Location permission denied.";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state = "Location permission permanently denied.";
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;

      state =
          "${place.locality ?? 'unknown'}, ${place.subAdministrativeArea ?? 'unknown'}, ${place.administrativeArea ?? 'unknown'}, ${place.country ?? 'unknown'}";
    } else {
      state = "Unable to fetch address details.";
    }
  }

  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = "Location services are disabled.";
        return;
      }

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        state = "Please enable location services and try again.";
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = "Location permission denied.";
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = "Location permission permanently denied.";
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        state =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}";
      } else {
        state = "Unable to find address.";
      }
    } catch (e) {
      state = "Error: $e";
    }
    isLoading = false;
  }
}
