import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kicksy/data/shoe.dart';

class Sneakers extends ConsumerStatefulWidget {
  final Shoe shoe;
  const Sneakers({super.key, required this.shoe});

  @override
  ConsumerState<Sneakers> createState() => _SneakersState();
}

class _SneakersState extends ConsumerState<Sneakers> {
  int selectedImage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Sneakers details"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xfff0f0f0),
                  image: DecorationImage(
                    image: AssetImage(
                      widget.shoe.picture[selectedImage],
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 70,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.shoe.picture.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedImage = index;
                          });
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
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 25,
              ),
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
                    const Icon(
                      Icons.favorite_border,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Align(
                widthFactor: 1.3,
                child: Text(
                  '\$ ${widget.shoe.cost.toString()}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: const Text("5 PairLeft"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Chip(
                    label: const Text("Sold 50"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Chip(
                    avatar: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                    label: const Row(
                      children: [
                        Text("4.7"),
                        Text(
                          "(69 Reviews)",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 15,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Size",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
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
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Chip(
                    backgroundColor: const Color.fromARGB(255, 101, 179, 103),
                    label: const Text("US 4"),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Chip(
                    label: const Text("US 4.5"),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Chip(
                    label: const Text("US 5"),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Chip(
                    label: const Text("US 5.5"),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  Chip(
                    label: const Text("US 6"),
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.message_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
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
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text(
                      "Buy Now",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
