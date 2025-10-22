import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/data/cart.dart';
import 'package:kicksy/data/shoe.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/cart/provider/cart_provider.dart';
import 'package:kicksy/pages/sneaker_detail/provider/sneaker_detail_provider.dart';

class SneakerDetailsPage extends ConsumerStatefulWidget {
  final Shoe shoe;
  const SneakerDetailsPage({super.key, required this.shoe});

  @override
  ConsumerState<SneakerDetailsPage> createState() => _SneakersState();
}

class _SneakersState extends ConsumerState<SneakerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final selectedSize = ref.watch(selectedSizeProvider);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: () => context.go('/home')),
        title: const Text("Sneakers details"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: 16.padAll,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      widget.shoe.picture[ref.watch(selectedImageProvider)],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              10.height,
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.shoe.picture.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ref.read(selectedImageProvider.notifier).state = index;
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 7),
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(widget.shoe.picture[index]),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                    );
                  },
                ),
              ),
              25.height,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.shoe.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(Icons.favorite_border, color: Colors.grey),
                  ],
                ),
              ),
              13.height,
              Align(
                widthFactor: 1.3,
                child: Text(
                  '₹${widget.shoe.cost.toString()}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: const Text("5 PairLeft"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Chip(
                    label: const Text("Sold 50"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Chip(
                    avatar: const Icon(Icons.star, color: Colors.yellow),
                    label: const Row(
                      children: [
                        Text("4.7"),
                        Text(
                          "(69 Reviews)",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              const Divider(height: 15, color: Colors.grey),
              10.height,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Select Size", style: TextStyle(fontSize: 20)),
                    Text(
                      "Size Chart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              15.height,
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.shoe.size.length,
                  itemBuilder: (context, index) {
                    final size = widget.shoe.size[index];
                    final isSelected = selectedSize == size;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        onPressed: () =>
                            ref.read(selectedSizeProvider.notifier).state =
                                size,
                        backgroundColor: isSelected
                            ? AppColor.primaryColor
                            : Colors.white,
                        label: Text(
                          size,

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? AppColor.secondaryColor
                                : AppColor.primaryColor,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.message_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      final size = ref.read(selectedSizeProvider);
                      if (size == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select a size")),
                        );
                        return;
                      }

                      final cart = Cart(
                        image: widget.shoe.image,
                        name: widget.shoe.name,
                        price: widget.shoe.cost.toString(),
                        shoe: widget.shoe,
                        size: size,
                      );

                      await ref.read(cartProvider.notifier).addItem(cart);
                      ref.read(selectedSizeProvider.notifier).state = null;

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Added to cart successfully"),
                        ),
                      );
                    },

                    icon: const Icon(
                      Icons.add_shopping_cart_rounded,
                      color: Colors.green,
                    ),
                    label: const Text(
                      "Add to Cart",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
