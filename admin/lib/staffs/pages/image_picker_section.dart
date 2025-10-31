import 'package:admin/extension/extension.dart';
import 'package:admin/staffs/provider/staffs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ImagePickerSection extends ConsumerWidget {
  const ImagePickerSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffState = ref.watch(staffsProvider);
    final provider = ref.read(staffsProvider.notifier);
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          GestureDetector(
            onTap: () => provider.pickImage(),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: staffState.webImage != null
                  ? MemoryImage(staffState.webImage!)
                  : staffState.image != null
                  ? FileImage(staffState.image!)
                  : null,
              backgroundColor: Color(0xFFE0E0E0),
              child: (staffState.webImage == null && staffState.image == null)
                  ? Icon(Icons.person, size: 55, color: Colors.grey)
                  : null,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              padding: 6.padAll,
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
