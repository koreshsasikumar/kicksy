import 'package:flutter/material.dart';
import 'package:kicksy/data/shoe.dart';
import 'package:kicksy/pages/sneaker_details_page.dart';

class AllItem extends StatefulWidget {
  const AllItem({super.key});

  @override
  State<AllItem> createState() => _AllItemWidgetState();
}

class _AllItemWidgetState extends State<AllItem> {
  final List<bool> likedList = [];

  @override
  void initState() {
    super.initState();
    likedList.addAll(List.generate(shoes.length, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8,
      ),
      itemCount: shoes.length,
      itemBuilder: (context, index) {
        final shoe = shoes[index];
        final isLiked = likedList[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SneakerDetailsPage(shoe: shoe),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color(0xfff0f0f0),
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: AssetImage(shoe.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          likedList[index] = !likedList[index];
                        });
                      },
                      child: AnimatedScale(
                         scale:  1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceInOut,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Container(
                            key: ValueKey<bool>(isLiked),
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.grey,
                              size: 19,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                shoe.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                '₹ ${shoe.cost}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
