import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  bool isLoading = true;

  final _fireStore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  String? selectedSize;

  double get totalPrice {
    return state.fold<double>(
      0,
      (sum, item) => sum + double.tryParse(item.price)!.toDouble(),
    );
  }

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
      cartId: docRef.id,
      userId: userId,
    );
    debugPrint("Cart ID:  ${docRef.id}");
    await docRef.set(newCart.toJson());
    state = [...state, newCart];
  }

  Future<void> fetchCartItems() async {
    isLoading = true;
    if (userId == null) return;
    state = [];
    final snapshot = await _fireStore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();

    final carts = snapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      debugPrint("Fetch Cart ID:  ${doc.id}");

      return Cart.fromjson(doc.data());
    }).toList();

    state = carts;
    isLoading = false;
  }

  Future<void> removeItem(String cartId) async {
    if (userId == null) return;
    await _fireStore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(cartId)
        .delete();
    state = state.where((c) => c.cartId != cartId).toList();
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
