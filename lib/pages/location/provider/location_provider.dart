import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:kicksy/pages/location/address.dart';

final locationProvider = StateNotifierProvider<LocationNotifier, Address>(
  (ref) => LocationNotifier(),
);

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
    if (userId == null) return;

    isLoading = true;
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        state = Address(
          houseNo: data['houseNo'] ?? '',
          city: data['city'] ?? '',
          state: data['state'] ?? '',
          pinCode: data['pinCode'] ?? '',
          fullAddress: data['fullAddress'] ?? 'No Address set yet',
        );
        _updateControllers();
      } else {
        _clearControllers();
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
    isLoading = false;
  }

  Future<void> submitLocation() async {
    if (userId == null) return;

    state = state.copyWith(
      houseNo: houseNoController.text,
      city: cityController.text,
      state: stateController.text,
      pinCode: pinCodeController.text,
      fullAddress:
          "${houseNoController.text}, ${cityController.text}, ${stateController.text}, ${pinCodeController.text}",
    );

    try {
      await _firestore.collection('users').doc(userId).set({
        'houseNo': state.houseNo,
        'city': state.city,
        'state': state.state,
        'pinCode': state.pinCode,
        'fullAddress': state.fullAddress,
        'timestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint("Error saving location: $e");
    }
  }

  Future<void> fetchCurrentLocation() async {
    isLoading = true;
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        state = Address(
          houseNo: place.street ?? '',
          city: place.locality ?? '',
          state: place.administrativeArea ?? '',
          pinCode: place.postalCode ?? '',
          fullAddress:
              "${place.street ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}",
        );
        _updateControllers();
      }
    } catch (e) {
      debugPrint("Error fetching location: $e");
    }
    isLoading = false;
  }

  void setHouseNo(String houseNo) =>
      state = state.copyWith(houseNo: houseNo, fullAddress: '');

  void setCity(String city) =>
      state = state.copyWith(city: city, fullAddress: '');

  void setState(String stateName) =>
      state = state.copyWith(state: stateName, fullAddress: '');

  void setPinCode(String pinCode) =>
      state = state.copyWith(pinCode: pinCode, fullAddress: '');

  void _updateControllers() {
    houseNoController.text = state.houseNo;
    cityController.text = state.city;
    stateController.text = state.state;
    pinCodeController.text = state.pinCode;
  }

  void _clearControllers() {
    houseNoController.clear();
    cityController.clear();
    stateController.clear();
    pinCodeController.clear();
  }
}
