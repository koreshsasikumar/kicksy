import 'package:admin/data/upload_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'dart:io';

final uploadProvider = StateNotifierProvider<UploadPageNotifier, UploadState>((
  ref,
) {
  return UploadPageNotifier();
});

class UploadPageNotifier extends StateNotifier<UploadState> {
  UploadPageNotifier() : super(UploadState());

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final decsriptionController = TextEditingController();

  final firebaseStorage = FirebaseStorage.instance;

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result == null) return;

    if (kIsWeb) {
      final bytes = result.files.single.bytes;
      if (bytes == null) return;
      List<Uint8List> newImages = List.from(state.webImage);
      newImages.add(bytes);
      state = state.copyWith(webImages: newImages);
    } else {
      final filePath = result.files.single.path;
      if (filePath == null) return;
      final file = File(filePath);
      List<File> newFiles = List.from(state.images);
      newFiles.add(file);
      state = state.copyWith(images: newFiles);
    }
  }

  Future<bool> uploadProduct() async {
    final name = nameController.text.trim();
    final price = priceController.text.trim();
    final description = decsriptionController.text.trim();
    if (name.isEmpty || (state.images.isEmpty && state.webImage.isEmpty))
      return false;

    state = state.copyWith(isLoading: true);

    try {
      List<String> imageUrls = [];

      if (kIsWeb) {
        for (var bytes in state.webImage) {
          final ref = firebaseStorage.ref().child(
            'products/${DateTime.now().millisecondsSinceEpoch}.jpg',
          );
          await ref.putData(bytes);
          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        }
      } else {
        for (var file in state.images) {
          final ref = firebaseStorage.ref().child(
            'products/${DateTime.now().millisecondsSinceEpoch}.jpg',
          );
          await ref.putFile(file);
          final url = await ref.getDownloadURL();
          imageUrls.add(url);
        }
      }

      await FirebaseFirestore.instance.collection('products').add({
        'name': name,
        'description': description,
        'price': price,
        'images': imageUrls,
        'createdAt': FieldValue.serverTimestamp(),
      });

      state = UploadState();
      return true;
    } catch (e) {
      print('Upload error: $e');
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  void clearState() {
    nameController.clear();
    priceController.clear();
    decsriptionController.clear();
  }
}
