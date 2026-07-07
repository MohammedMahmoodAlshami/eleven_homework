import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getProductsStream() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      final products = <Product>[];
      for (final doc in snapshot.docs) {
        try {
          products.add(Product.fromDoc(doc));
        } catch (e, stack) {
          debugPrint('Skipping malformed product ${doc.id}: $e\n$stack');
        }
      }
      return products;
    }).handleError((Object error, StackTrace stack) {
      debugPrint('Products stream error: $error\n$stack');
      throw _mapFirestoreError(error);
    });
  }

  Exception _mapFirestoreError(Object error) {
    if (error is FirebaseException) {
      switch (error.code) {
        case 'permission-denied':
          return Exception('لا تملك صلاحية قراءة المنتجات.');
        case 'unavailable':
          return Exception('خدمة Firestore غير متاحة. تحقق من اتصالك بالإنترنت.');
        default:
          return Exception(error.message ?? 'حدث خطأ أثناء تحميل المنتجات.');
      }
    }
    return Exception('حدث خطأ أثناء تحميل المنتجات: $error');
  }
}
