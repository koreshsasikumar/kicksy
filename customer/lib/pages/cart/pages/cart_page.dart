import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/cart/provider/cart_provider.dart';
import 'package:kicksy/pages/cart/pages/cart_item.dart';
import 'package:kicksy/pages/location/provider/location_provider.dart';

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
    final location = ref.watch(locationProvider);

    final total = ref.watch(cartProvider.notifier).totalPrice;
    return Scaffold(
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
            child: BackButton(onPressed: () => context.go('/home')),
          ),
        ),
        title: Text(
          'Cart',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
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
                    padding: 12.padAll,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ship to:',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                        8.width,
                        Expanded(
                          child: location.isLoading
                              ? const SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  location.fullAddress.isEmpty
                                      ? "No Address set yet"
                                      : location.fullAddress,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 76, 170, 78),
                                  ),
                                  softWrap: true,
                                ),
                        ),
                        IconButton(
                          onPressed: () => context.go('/location_page'),
                          icon: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.grey,
                          ),
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
