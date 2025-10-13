
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/data/cart_data.dart';
import 'package:kicksy/pages/cart/provider/cart_provider.dart';
import 'package:kicksy/widgets/cart_item.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({
    super.key,
  });

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

int subtotal = cartItems.fold(0, (price, cart) => price + cart.price);
double deliveryfee = 15.00;
double discount = -200.00;
double total = subtotal + deliveryfee + discount;

class _CartPageState extends ConsumerState<CartPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(cartProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    241,
                    238,
                    238,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              height: 30,
              width: 25,
              child: const BackButton()),
        ),
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    241,
                    238,
                    238,
                  ),
                  borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/shop.jpeg'),
                    minRadius: 9,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    'Ship to',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color.fromARGB(255, 141, 135, 135)),
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  const Text(
                    'Rex Hypebeast',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Text(
                    'Tegalsari,Surabaya',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 76, 170, 78),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return CartItem(
                    image: cartItems[index].image,
                    name: cartItems[index].name,
                    price: ('\$ ${cartItems[index].price}'),
                  );
                }),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Have a coupon code?',
                    style: TextStyle(
                        color: Color.fromARGB(255, 141, 137, 137),
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 35,
                    width: 400,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'coupon code',
                        hintStyle: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 173, 167, 167)),
                        suffixIcon: const Icon(
                          Icons.verified_outlined,
                          color: Colors.green,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Sub Total',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      Text(
                          '\$ ${cartItems.fold(0.00, (price, cart) => price + cart.price)}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Fee',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('\$$deliveryfee',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Discount',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('\$ $discount',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    height: 15,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                      Text('\$ ${subtotal + deliveryfee + discount}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 35,
                    width: 400,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
