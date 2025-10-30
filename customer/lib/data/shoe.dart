List<Shoe> shoes = [
  Shoe(
    id: '1',
    name: 'MAG BTTF 2016',
    image: 'assets/images/1.png',
    picture: [
      'assets/images/11.webp',
      'assets/images/12.webp',
      'assets/images/13.webp',
      'assets/images/14.webp',
    ],
    size: ['6', '7', '8', '9', '10'],
    cost: 500,
  ),
  Shoe(
    id: '2',
    name: 'Air Stab',
    image: 'assets/images/2.png',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      "assets/images/21.jpeg",
      'assets/images/22.jpg',
      'assets/images/23.jpeg',
      'assets/images/24.jpeg',
    ],
    cost: 600,
  ),
  Shoe(
    id: '3',
    name: 'Air YEEZY 2 NRG',
    image: 'assets/images/3.jpg',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      'assets/images/31.png',
      'assets/images/32.jpeg',
      'assets/images/33.jpeg',
    ],
    cost: 600,
  ),
  Shoe(
    id: '4',
    name: 'JORDAN 1',
    image: 'assets/images/4.jpg',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      'assets/images/41.webp',
      'assets/images/42.jpg',
      'assets/images/43.jpeg',
      'assets/images/44.jpg',
    ],
    cost: 550,
  ),
  Shoe(
    id: '5',
    name: 'AIR YEEZY 1 NET TAN',
    image: 'assets/images/5.jpg',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      'assets/images/51.jpeg',
      'assets/images/52.jpeg',
      'assets/images/53.jpeg',
      'assets/images/54.webp',
    ],
    cost: 900,
  ),
  Shoe(
    id: '6',
    name: 'LEBRON 10 WHAT THE MVP',
    image: 'assets/images/6.jpg',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      'assets/images/61.png',
      'assets/images/62.jpeg',
      'assets/images/63.jpg',
    ],
    cost: 700,
  ),
  Shoe(
    id: '7',
    name: 'Nike Legend Essential 3',
    image: 'assets/images/7.jpg',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      'assets/images/71.webp',
      'assets/images/72.webp',
      'assets/images/73.jpeg',
      'assets/images/74.webp',
    ],
    cost: 1500,
  ),
  Shoe(
    id: '8',
    name: 'Canvas NET 1',
    image: 'assets/images/8.png',
    size: ['6', '7', '8', '9', '10'],
    picture: [
      'assets/images/81.jpeg',
      'assets/images/82.jpeg',
      'assets/images/83.jpeg',
      'assets/images/84.jpg',
    ],
    cost: 1000,
  ),
];

class Shoe {
  String? id;
  String name;
  String image;
  int cost;
  List<String> picture;
  List<String> size;

  Shoe({
    required this.id,
    required this.name,
    required this.image,
    required this.cost,
    required this.size,
    required this.picture,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'cost': cost,
      'size': size,
      'picture': picture,
    };
  }

  factory Shoe.fromJson(Map<String, dynamic> json) {
    return Shoe(
      id: json['id'] as String?,
      name: json['name'] as String,
      image: json['image'] as String,
      cost: json['cost'] as int,
      size: List<String>.from(json['size'] as List<dynamic>),
      picture: List<String>.from(json['picture'] as List<dynamic>),
    );
  }
}
