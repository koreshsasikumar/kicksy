import 'dart:io';

import 'package:admin/data/staff_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final staffsProvider = StateNotifierProvider<StaffsProvider, StaffState>((ref) {
  return StaffsProvider();
});

class StaffsProvider extends StateNotifier<StaffState> {
  StaffsProvider()
    : super(
        StaffState(
          id: '',
          name: '',
          email: '',
          phoneNumber: '',
          staffList: const [],
          isActive: false,
        ),
      );

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;

  Future<void> fetchStaffs() async {
    try {
      state = state.copyWith(isLoading: true);

      final snapShot = await fireStore
          .collection('staffs')
          .orderBy('createdAt', descending: true)
          .get();

      final List<Map<String, dynamic>> newList = [];
      for (var doc in snapShot.docs) {
        newList.add(doc.data());
      }
      state = state.copyWith(staffList: newList, isLoading: false);
    } catch (e) {
      debugPrint('Error fetching staffs: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteStaff(String staffId) async {
    try {
      state = state.copyWith(isLoading: true);
      await fireStore.collection('staffs').doc(staffId).delete();
    } catch (e) {
      debugPrint("Error staff:$e");
      state = state.copyWith(isLoading: false);
    }
  }

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+(com|net|org)$');
    if (!emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone Number is required";
    }
    String cleaned = value.replaceAll(RegExp(r'[\s-]'), '');
    if (cleaned.startsWith('+91')) {
      cleaned = cleaned.substring(3);
    }
    cleaned = cleaned.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length != 10) {
      return "Enter a valid phone number (10 digits)";
    }
    if (value.replaceAll(RegExp(r'[^0-9]'), '').length < 10) {
      return "Enter a valid phone number (min 10 digits)";
    }
    return null;
  }

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );

      if (result == null) {
        return;
      }

      if (kIsWeb) {
        final bytes = result.files.single.bytes;
        if (bytes != null) {
          state = state.copyWith(webImages: bytes);
        }
      } else {
        final filePath = result.files.single.path;
        if (filePath != null) {
          final file = File(filePath);
          state = state.copyWith(image: file);
        }
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  bool toggleIsActive(bool value) {
    state = state.copyWith(isActive: value);
    return state.isActive;
  }

  Future<bool> saveStaff() async {
    state = state.copyWith(isLoading: true);
    try {
      String? imageUrl;

      if (state.image != null || state.webImage != null) {
        final fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
        final storageRef = FirebaseStorage.instance.ref().child(
          'staffs/$fileName',
        );

        UploadTask uploadTask;

        if (kIsWeb && state.webImage != null) {
          uploadTask = storageRef.putData(state.webImage!);
        } else if (state.image != null) {
          uploadTask = storageRef.putFile(state.image!);
        } else {
          throw Exception("No image found");
        }

        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        imageUrl = downloadUrl;
      }

      final docRef = FirebaseFirestore.instance.collection('staffs').doc();
      await docRef.set({
        'id': docRef.id,
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'phoneNumber': phoneNumberController.text.trim(),
        'isActive': state.isActive,
        'imageUrl': imageUrl ?? '',
        'createdAt': FieldValue.serverTimestamp(),
      });
      await fetchStaffs();
      clearState();
      state = state.copyWith(isLoading: false);

      return true;
    } catch (e) {
      debugPrint("Error saving staff: $e");
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  void clearState() {
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    state = StaffState(
      id: '',
      name: '',
      email: '',
      phoneNumber: '',
      image: null,
      isActive: false,
      webImage: null,
      staffList: state.staffList,
    );
  }
}
