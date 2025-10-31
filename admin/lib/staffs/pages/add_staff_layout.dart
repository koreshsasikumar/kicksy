import 'package:admin/extension/extension.dart';
import 'package:admin/staffs/provider/staffs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddStaffLayout extends ConsumerStatefulWidget {
  const AddStaffLayout({super.key});

  @override
  ConsumerState<AddStaffLayout> createState() => _AddStaffLayoutState();
}

class _AddStaffLayoutState extends ConsumerState<AddStaffLayout> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final provider = ref.read(staffsProvider.notifier);
    final staffState = ref.watch(staffsProvider);
    final theme = Theme.of(context);

    return SafeArea(
      child: Drawer(
        width: 400,
        elevation: 16,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: 16.padAll,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Add Staff",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        provider.clearState();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                const Divider(),
                20.height,

                Center(
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
                          child:
                              (staffState.webImage == null &&
                                  staffState.image == null)
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
                ),

                24.height,
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: provider.nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: provider.nameValidation,
                      ),
                      16.height,
                      TextFormField(
                        controller: provider.phoneNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(),
                        ),
                        validator: provider.phoneNumberValidation,
                      ),
                      16.height,
                      TextFormField(
                        controller: provider.emailController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Email Id",
                          border: OutlineInputBorder(),
                        ),
                        validator: provider.emailValidation,
                      ),
                      SwitchListTile(
                        title: const Text("Active"),
                        value: staffState.isActive,
                        onChanged: provider.toggleIsActive,
                      ),
                      20.height,

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                provider.clearState();
                                Navigator.pop(context);
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.grey),
                              ),
                              child: const Text("Cancel"),
                            ),
                          ),
                          12.width,
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  debugPrint(
                                    'Name: ${provider.nameController.text}',
                                  );
                                  debugPrint(
                                    'Email: ${provider.emailController.text}',
                                  );
                                  debugPrint(
                                    'Phone: ${provider.phoneNumberController.text}',
                                  );
                                  final success = await provider.saveStaff();
                                  if (success) {
                                    provider.clearState();

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          success
                                              ? 'Staff added successfully!'
                                              : 'Failed to upload product. Try again.',
                                        ),
                                        backgroundColor: success
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: const Text(
                                "Save",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
