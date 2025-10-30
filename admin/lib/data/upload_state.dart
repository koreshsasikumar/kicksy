import 'dart:io';

import 'package:flutter/foundation.dart';

class UploadState {
  final String name;
  final String description;
  final double price;
  final List<File> images;
  final List<Uint8List> webImage;
  final bool isLoading;

  UploadState({
    this.webImage = const [],
    this.name = '',
    this.description = '',
    this.images = const [],
    this.isLoading = false,
    this.price = 0,
  });
  UploadState copyWith({
    String? name,
    String? description,
    double? price,
    List<File>? images,
    List<Uint8List>? webImages,
    bool? isLoading,
  }) {
    return UploadState(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      webImage: webImages ?? this.webImage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
