import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/data/shoe.dart';
import 'package:kicksy/pages/favourite/provider/favourite_provider.dart';

class AllItem extends ConsumerStatefulWidget {
  const AllItem({super.key});

  @override
  ConsumerState<AllItem> createState() => _AllItemWidgetState();
}

class _AllItemWidgetState extends ConsumerState<AllItem> {
  @override
  Widget build(BuildContext context) {
    final favourite = ref.watch(favoriteProvider.notifier);
    ref.watch(favoriteProvider);

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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      context.go('/sneaker_detail');
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
                      onTap: () async {
                        await favourite.addFavorites(shoe);
                      },
                      child: AnimatedScale(
                        scale: 1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceInOut,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, anim) =>
                              ScaleTransition(scale: anim, child: child),
                          child: Container(
                            key: ValueKey<bool>(favourite.isFavorite(shoe)),
                            height: 25,
                            width: 25,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(
                              favourite.isFavorite(shoe)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: favourite.isFavorite(shoe)
                                  ? Colors.red
                                  : Colors.grey,
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
