import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kicksy/data/shoe.dart';

final favoriteProvider = StateNotifierProvider<FavoriteProvider, List<Shoe>>((
  ref,
) {
  return FavoriteProvider();
});

class FavoriteProvider extends StateNotifier<List<Shoe>> {
  FavoriteProvider() : super([]) {
    fetchFavorites();
  }

  bool isLoading = true;

  final _fireStore = FirebaseFirestore.instance;
  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> addFavorites(Shoe shoe) async {
    if (userId == null || shoe.id == null || shoe.id!.isEmpty) return;
    final docRef = _fireStore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(shoe.id);

    if (isFavorite(shoe)) {
      await docRef.delete();
      state = state.where((item) => item.id != shoe.id).toList();
    } else {
      await docRef.set(shoe.toJson());
      state = [...state, shoe];
    }
  }

  Future<void> fetchFavorites() async {
    isLoading = true;
    if (userId == null) return;
    state = [];

    final snapshot = await _fireStore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    final favoriteShoes = snapshot.docs.map((doc) {
      final data = doc.data();
      return Shoe.fromJson({...data, 'id': doc.id});
    }).toList();

    state = favoriteShoes;
    isLoading = false;
  }

  Future<void> removeFavorites(Shoe shoe) async {
    debugPrint('Removing favorite: ${shoe.id}');

    if (userId == null || shoe.id == null || shoe.id!.isEmpty) return;
    await _fireStore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(shoe.id)
        .delete();
    state = state.where((c) => c.id != shoe.id).toList();
  }

  bool isFavorite(Shoe shoe) => state.any((item) => item.id == shoe.id);

  void clearFavorites() {
    state = [];
    if (userId != null) {
      _fireStore
          .collection('users')
          .doc(userId)
          .collection('favorites')
          .get()
          .then((snapshot) {
            for (var doc in snapshot.docs) {
              doc.reference.delete();
            }
          });
    }
  }
}
