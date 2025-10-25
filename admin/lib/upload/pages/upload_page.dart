import 'package:admin/upload/provider/upload_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadPage extends ConsumerStatefulWidget {
  const UploadPage({super.key});

  @override
  ConsumerState<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends ConsumerState<UploadPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadProvider);
    final provider = ref.read(uploadProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Product'),
        backgroundColor: Colors.green[400],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => provider.pickImage(),
                      child: Container(
                        width: double.infinity,
                        height: 180,
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[100],
                        ),
                        child: kIsWeb
                            ? (index < uploadState.webImage.length
                                  ? Image.memory(
                                      uploadState.webImage[index],
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    ))
                            : (index < uploadState.images.length
                                  ? Image.file(
                                      uploadState.images[index],
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 40,
                                        color: Colors.grey,
                                      ),
                                    )),
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 20),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
                controller: provider.nameController,
                validator: (v) => v!.isEmpty ? 'Enter product name' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: provider.priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,

                validator: (v) => v!.isEmpty ? 'Enter price' : null,
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: provider.decsriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),

              Center(
                child: uploadState.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final success = await provider.uploadProduct();
                            if (success) {
                              provider.clearState();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Product uploaded successfully!',
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Failed to upload product. Try again.',
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },

                        icon: const Icon(Icons.cloud_upload),
                        label: const Text('Upload Product'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
