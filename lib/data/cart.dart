import 'package:kicksy/data/shoe.dart';

class Cart {
  String id;
  Shoe shoe;
  String image;
  String name;
  String price;
  String size;

  Cart({
    this.id = '',
    required this.image,
    required this.name,
    required this.price,
    required this.shoe,
    required this.size,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'image': image,
    'name': name,
    'price': price,
    'size': size,
  };

  factory Cart.fromjson(Map<String, dynamic> json) => Cart(
    id: json['id'] ?? '',
    image: json['image'] ?? '',
    name: json['name'] ?? '',
    price: json['price'] ?? '',
    shoe:
        json['shoe'] ??
        Shoe(
          name: json['name'] ?? '',
          image: json['image'],
          cost: int.tryParse(json['price'] ?? '0') ?? 0,
          size: [],
          picture: [],
        ),
    size: json['size'] ?? '',
  );
}
