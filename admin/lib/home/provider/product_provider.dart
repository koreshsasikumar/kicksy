import 'package:admin/data/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('products')
      .get();

  return querySnapshot.docs
      .map((doc) => Product.fromMap(doc.id, doc.data()))
      .toList();
});
