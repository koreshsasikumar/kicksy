import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kicksy/pages/location/address.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, Address>((
  ref,
) {
  return LocationNotifier();
});

class LocationNotifier extends StateNotifier<Address> {
  LocationNotifier() : super(Address()) {
    fetchSavedLocation();
  }

  final houseNoController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final pinCodeController = TextEditingController();
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;


  Future<void> fetchSavedLocation() async {
    String? userId = this.userId;
    if (userId == null) {
      debugPrint('User is not logged in, cannot fetch location.');
      return;
    }

    try {
      isLoading = true;
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;

        state = state.copyWith(
          houseNo: data['houseNo'] as String? ?? 'unknown',
          city: data['city'] as String? ?? 'unknown',
          state: data['state'] as String? ?? 'unknown',
          pinCode: data['pinCode'] as String? ?? 'unknown',
          fullAddress: data['fullAddress'] as String? ?? 'No Address set yet',
        );

       
        houseNoController.text = state.houseNo != 'unknown'
            ? state.houseNo
            : '';
        cityController.text = state.city != 'unknown' ? state.city : '';
        stateController.text = state.state != 'unknown' ? state.state : '';
        pinCodeController.text = state.pinCode != 'unknown'
            ? state.pinCode
            : '';

        debugPrint('Location loaded from Firebase: ${state.fullAddress}');
      } else {
        debugPrint('No saved location found for user.');
        houseNoController.clear();
        cityController.clear();
        stateController.clear();
        pinCodeController.clear();
      }
    } catch (e) {
      debugPrint('Error fetching location from Firebase: $e');
    } finally {
      isLoading = false;
    }
  }

  Future<void> submitLocation() async {
    String? userId = this.userId;
    if (userId == null) {
      debugPrint('User is not logged in');
      return;
    }

    try {
      state = state.copyWith(
        houseNo: houseNoController.text,
        city: cityController.text,
        state: stateController.text,
        pinCode: pinCodeController.text,
      );
      final submitLocation =
          "${state.houseNo}, ${state.city}, ${state.state}, ${state.pinCode}";
      state = state.copyWith(fullAddress: submitLocation);
      await _firestore.collection('users').doc(userId).set({
        'houseNo': state.houseNo,
        'city': state.city,
        'state': state.state,
        'pinCode': state.pinCode,
        'fullAddress': state.fullAddress,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      debugPrint('Location saved to Firebase successfully!');
    } catch (e) {
      debugPrint('Error saving location to Firebase: $e');
    }
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      state = state.copyWith(fullAddress: "Location services are disabled.");
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        state = state.copyWith(fullAddress: "Location permission denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      state = state.copyWith(
        fullAddress: "Location permission permanently denied.",
      );
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

      state = state.copyWith(
        houseNo: place.street ?? 'unknown',
        city: place.locality ?? 'unknown',
        state: place.administrativeArea ?? 'unknown',
        pinCode: place.postalCode ?? 'unknown',
        fullAddress:
            "${place.locality ?? 'unknown'}, ${place.subAdministrativeArea ?? 'unknown'}, ${place.administrativeArea ?? 'unknown'}, ${place.country ?? 'unknown'}",
      );
    } else {
      state = state.copyWith(fullAddress: "Unable to fetch address details.");
    }
  }

  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        state = state.copyWith(fullAddress: "Location services are disabled.");
        return;
      }

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        state = state.copyWith(
          fullAddress: "Please enable location services and try again.",
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          state = state.copyWith(fullAddress: "Location permission denied.");
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        state = state.copyWith(
          fullAddress: "Location permission permanently denied.",
        );
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
        state = state.copyWith(
          houseNo: place.street ?? 'unknown',
          city: place.locality ?? 'unknown',
          state: place.administrativeArea ?? 'unknown',
          pinCode: place.postalCode ?? 'unknown',
          fullAddress:
              "${place.locality ?? 'unknown'}, ${place.subAdministrativeArea ?? 'unknown'}, ${place.administrativeArea ?? 'unknown'}, ${place.country ?? 'unknown'}",
        );
      } else {
        state = state.copyWith(fullAddress: "Unable to find address.");
      }
    } catch (e) {
      state = state.copyWith(fullAddress: "Error: $e");
    }
    isLoading = false;
  }

  void setHouseNo(String houseNo) {
    state = state.copyWith(houseNo: houseNo);
    debugPrint("HouseNo set to: $houseNo");
  }

  void setCity(String city) {
    state = state.copyWith(city: city);
    debugPrint("City set to: $city");
  }

  void setState(String stateName) {
    state = state.copyWith(state: stateName);
    debugPrint("State set to: $stateName");
  }

  void setPinCode(String pinCode) {
    state = state.copyWith(pinCode: pinCode);
    debugPrint("PinCode set to: $pinCode");
  }
}
