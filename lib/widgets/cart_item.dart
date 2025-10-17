import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/cart/provider/cart_provider.dart';

class CartItem extends ConsumerStatefulWidget {
  final String cartId;
  final String image;
  final String name;
  final String price;
  final int index;
  final String size;

  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.index,
    required this.size,
    required this.cartId,
  });

  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(cartProvider.notifier);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              widget.image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),

          12.width,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                5.height,

                Text(
                  "Size: ${widget.size}",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                5.height,

                Text(
                  widget.price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.backgroundDark,
                  ),
                ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => provider.removeItem(widget.cartId),
                icon: const Icon(Icons.delete, color: Colors.redAccent),
              ),

              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 241, 238, 238),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                        icon: const Icon(
                          CupertinoIcons.minus,
                          color: Colors.green,
                          size: 16,
                        ),
                      ),
                    ),

                    Text(
                      "$quantity",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => setState(() => quantity++),
                        icon: const Icon(
                          CupertinoIcons.plus,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
