import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../data/dummy_data.dart'; // Make sure this contains the products list

class FirestoreSeeder {
  static Future<void> seedProducts() async {
    final firestore = FirebaseFirestore.instance;
    final batch = firestore.batch();

    try {
      for (var product in products) {
        final docRef = firestore.collection('products').doc(product.id);
        batch.set(docRef, product.toMap());
      }

      await batch.commit();
      debugPrint('Successfully seeded products into Firestore.');
    } catch (e) {
      debugPrint('Error seeding products: $e');
    }
  }
}
