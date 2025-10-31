import 'dart:io';
import 'dart:typed_data';

class StaffState {
  final List<Map<String, dynamic>> staffList;

  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final Uint8List? webImage;
  final File? image;
  final bool isActive;
  final bool isLoading;

  StaffState({
    this.webImage,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.image,
    this.isActive = false,
    this.isLoading = false,
    this.staffList = const [],
  });

  StaffState copyWith({
    String? id,
    String? name,
    Uint8List? webImages,
    String? phoneNumber,
    String? email,
    File? image,
    bool? isActive,
    bool? isLoading,
    List<Map<String, dynamic>>? staffList,
  }) {
    return StaffState(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      webImage: webImages ?? this.webImage,
      isActive: isActive ?? this.isActive,
      image: image ?? this.image,
      isLoading: isLoading ?? this.isLoading,
      staffList: staffList ?? this.staffList,
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'email': email, 'phoneNumber': phoneNumber};
  }

  factory StaffState.fromMap(Map<String, dynamic> map) {
    return StaffState(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      isActive: map['isActive'] ?? '',
    );
  }
}
