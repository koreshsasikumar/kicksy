import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kicksy/appTheme/app_color.dart';
import 'package:kicksy/data/brand.dart';
import 'package:kicksy/extension/extension.dart';
import 'package:kicksy/pages/cart/cart_page.dart';
import 'package:kicksy/pages/cart/provider/cart_provider.dart';
import 'package:kicksy/widgets/all_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final provider = ref.watch(cartProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 40,
            width: 35,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 241, 238, 238),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.more_vert),
          ),
        ),
        title: Text(
          'Home',
          style: theme.textTheme.titleLarge?.copyWith(
            color: AppColor.backgroundDark,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 40,
              width: 35,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 241, 238, 238),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Badge.count(
                  backgroundColor: const Color.fromARGB(255, 241, 86, 74),
                  textStyle: const TextStyle(fontSize: 9.9),
                  count: provider.length,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    child: const Icon(Icons.shopping_bag_outlined),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  width: 400,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      //     fillColor: Color.fromARGB(255, 241, 238, 238),
                      hintText: 'What are you looking for ?',
                      hintStyle: TextStyle(
                        height: 5,
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(Icons.search_sharp),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              14.height,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_rounded,
                      size: 18,
                      color: Color.fromARGB(255, 40, 148, 43),
                    ),
                    5.height,
                    const Text(
                      'Ship to',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color.fromARGB(255, 141, 135, 135),
                      ),
                    ),
                    3.width,
                    const Text(
                      'JI.Malioboro,Blok Z,no 18',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: brands.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(brands[index].image),
                          ),
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 241, 238, 238),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 350,
                height: 120,
                child: Card(
                  color: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/black_shoe.jpg',
                        alignment: const Alignment(-0.80, -0.80),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            const Text(
                              'Year-End Sale',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Up To 90%',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 116, 111, 111),
                              ),
                            ),
                            8.height,
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor,
                                ),
                                child: const Text(
                                  'Shop Now',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
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
              ),
              40.height,
              const AllItem(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.favorite_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outlined),
              onPressed: () => context.go('/profile_page'),
            ),
            IconButton(
              icon: const Icon(Icons.notification_add_outlined),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
