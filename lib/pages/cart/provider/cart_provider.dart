import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kicksy/data/cart.dart';

final cartProvider = StateNotifierProvider<CartProvider, List<Cart>>((ref) {
  return CartProvider();
});

final selectedSizeProvider = StateProvider<String?>((ref) => null);

class CartProvider extends StateNotifier<List<Cart>> {
  CartProvider() : super([]) {
    fetchCartItems();
  }

  final _fireStore = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;

  String? selectedSize;

  Future<void> addItem(Cart cart) async {
    if (userId == null) return;
    final docRef = _fireStore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc();

    final newCart = Cart(
      image: cart.image,
      name: cart.name,
      price: cart.price,
      shoe: cart.shoe,
      size: cart.size,
      id: docRef.id,
    );
    await docRef.set(newCart.toJson());
    state = [...state, newCart];
  }

  Future<void> fetchCartItems() async {
    if (userId == null) return;
    final snapshot = await _fireStore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();
    final carts = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      return Cart.fromjson(doc.data());
    }).toList();

    state = carts;
  }

  double get totalPrice {
    return state.fold<double>(
      0,
      (sum, item) => sum + double.tryParse(item.price)!.toDouble(),
    );
  }

  Future<void> removeItem(String cartId) async {
    if (userId == null) return;
    await _fireStore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartId)
        .delete();
    state = state.where((c) => c.id != cartId).toList();
  }

  void clearCart() {
    if (userId != null) {
      _fireStore.collection('users').doc(userId).collection('cart').get().then((
        snapshot,
      ) {
        for (var doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
    }
    state = [];
  }
}
