List<Shoe> shoes = [
  Shoe(
      name: 'MAG BTTF 2016',
      image: 'assets/images/1.png',
      picture: [
        'assets/images/11.webp',
        'assets/images/12.webp',
        'assets/images/13.webp',
        'assets/images/14.webp',
      ],
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      cost: 20),
  Shoe(
      name: 'Air Stab',
      image: 'assets/images/2.png',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        "assets/images/21.jpeg",
        'assets/images/22.jpg',
        'assets/images/23.jpeg',
        'assets/images/24.jpeg',
      ],
      cost: 25),
  Shoe(
      name: 'Air YEEZY 2 NRG',
      image: 'assets/images/3.jpg',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        'assets/images/31.png',
        'assets/images/32.jpeg',
        'assets/images/33.jpeg',
      ],
      cost: 10),
  Shoe(
      name: 'JORDAN 1',
      image: 'assets/images/4.jpg',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        'assets/images/41.webp',
        'assets/images/42.jpg',
        'assets/images/43.jpeg',
        'assets/images/44.jpg',
      ],
      cost: 15),
  Shoe(
      name: 'AIR YEEZY 1 NET TAN',
      image: 'assets/images/5.jpg',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        'assets/images/51.jpeg',
        'assets/images/52.jpeg',
        'assets/images/53.jpeg',
        'assets/images/54.webp',
      ],
      cost: 14),
  Shoe(
      name: 'LEBRON 10 WHAT THE MVP',
      image: 'assets/images/6.jpg',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        'assets/images/61.png',
        'assets/images/62.jpeg',
        'assets/images/63.jpg',
      ],
      cost: 18),
  Shoe(
      name: 'Nike Legend Essential 3',
      image: 'assets/images/7.jpg',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        'assets/images/71.webp',
        'assets/images/72.webp',
        'assets/images/73.jpeg',
        'assets/images/74.webp',
      ],
      cost: 20),
  Shoe(
      name: 'Canvas NET 1',
      image: 'assets/images/8.png',
      size: ['US4', 'US4.5', 'US5', 'US5.5', 'US6'],
      picture: [
        'assets/images/81.jpeg',
        'assets/images/82.jpeg',
        'assets/images/83.jpeg',
        'assets/images/84.jpg',
      ],
      cost: 5000),
];

class Shoe {
  String name;
  String image;
  int cost;
  List<String> picture;
  List<String> size;

  Shoe(
      {required this.name,
      required this.image,
      required this.cost,
      required this.size,
      required this.picture});
}
