List<Cart> cartItems = [
  Cart(
    image: 'assets/images/1.png',
    name: 'MAG BTTF 2016',
    price: 2000,
  ),
  Cart(
    image: 'assets/images/2.png',
    name: 'Air Stab YEEZY 4 ',
    price: 2500,
  ),
  Cart(
    image: 'assets/images/3.jpg',
    name: 'Air YEEZY 2 NRG',
    price: 2000,
  )
];

class Cart {
  String image;
  String name;
  int price;

  Cart({
    required this.image,
    required this.name,
    required this.price,
  });
}
