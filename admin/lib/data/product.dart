class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final List<String> images;
  final bool approved;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.images,
    required this.approved,
  });

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      approved: map['approved'] ?? false,
    );
  }
}
