import 'package:flutter_riverpod/legacy.dart';
import 'package:kicksy/data/shoe.dart';

final cartProvider = StateNotifierProvider<CartProvider, List<Shoe>>((ref) {
  return CartProvider();
});

class CartProvider extends StateNotifier<List<Shoe>> {
  CartProvider() : super([]);

  void addItem(Shoe shoe) {
    state = [...state, shoe];
  }

  void removeItem(Shoe shoe) {
    state = state.where((s) => s != shoe).toList();
  }

  void clearCart() {
    state = [];
  }
}
