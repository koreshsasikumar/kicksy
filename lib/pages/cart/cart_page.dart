import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/auth/register/provider/auth_provider.dart';
import 'package:kicksy/pages/cart/provider/cart_provider.dart';
import 'package:kicksy/widgets/cart_item.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(cartProvider.notifier).fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartItems = ref.watch(cartProvider);
    final cartNotifier = ref.watch(cartProvider.notifier);

    final total = ref.watch(cartProvider.notifier).totalPrice;
    final registerState = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 241, 238, 238),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 30,
            width: 25,
            child: const BackButton(),
          ),
        ),
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 238, 238),
                borderRadius: BorderRadius.circular(20),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ),
        ],
      ),
      body: cartNotifier.isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/images/shop.jpeg',
                          ),
                          minRadius: 9,
                        ),
                        5.height,
                        const Text(
                          'Ship to:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Color.fromARGB(255, 141, 135, 135),
                          ),
                        ),
                        5.width,
                        Text(
                          registerState.name,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColor.backgroundDark,
                          ),
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
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItem(
                        cartId: item.cartId,
                        image: item.image,
                        name: item.name,
                        index: index,
                        size: item.size,
                        price: ('₹ ${cartItems[index].price}'),
                      );
                    },
                  ),
                  8.height,
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.height,
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
                                color: Color.fromARGB(255, 173, 167, 167),
                              ),
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

                        const Divider(height: 15, color: Colors.grey),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '₹ $total',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        20.height,
                        const Divider(height: 15, color: Colors.grey),
                        10.height,
                        SizedBox(
                          height: 35,
                          width: 400,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text(
                              "Place Order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
