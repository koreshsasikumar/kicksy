import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String name;
  final String price;

  const CartItem(
      {super.key,
      required this.image,
      required this.name,
      required this.price});

  @override
  State<CartItem> createState() => _CartItemState();
}

int number = 0;

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                widget.image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              //   mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 141, 135, 135),
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.price,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              height: 35,
              width: 100,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    241,
                    238,
                    238,
                  ),
                  borderRadius: BorderRadius.circular(19)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              // shoes.map((e) => null)
                              if (number > 0) {
                                number--;
                              }
                            });
                          },
                          icon: const Icon(
                            CupertinoIcons.minus,
                            color: Color.fromARGB(255, 72, 201, 76),
                            size: 12,
                          ))),
                  Text(
                    "$number",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            number++;
                          });
                        },
                        icon: const Icon(CupertinoIcons.plus,
                            color: Colors.white, size: 12),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
