import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/product.dart';

class FavoritesRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> getFavoritesStream(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots()
        .map((snapshot) {
      final favorites = <Product>[];
      for (final doc in snapshot.docs) {
        try {
          favorites.add(Product.fromDoc(doc));
        } catch (e, stack) {
          debugPrint('Skipping malformed favorite ${doc.id}: $e\n$stack');
        }
      }
      return favorites;
    }).handleError((Object error, StackTrace stack) {
      debugPrint('Favorites stream error: $error\n$stack');
      throw _mapFirestoreError(error);
    });
  }

  Future<void> addFavorite(String uid, Product product) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(product.id)
          .set(product.toMap());
    } on FirebaseException catch (e) {
      debugPrint('Error adding favorite: $e');
      throw _mapFirestoreError(e);
    } catch (e) {
      debugPrint('Error adding favorite: $e');
      rethrow;
    }
  }

  Future<void> removeFavorite(String uid, String productId) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      debugPrint('Error removing favorite: $e');
      throw _mapFirestoreError(e);
    } catch (e) {
      debugPrint('Error removing favorite: $e');
      rethrow;
    }
  }

  Exception _mapFirestoreError(Object error) {
    if (error is FirebaseException) {
      switch (error.code) {
      case 'permission-denied':
        return Exception('لا تملك صلاحية تعديل المفضلة.');
      case 'not-found':
        return Exception('المنتج غير موجود في المفضلة.');
      case 'unavailable':
        return Exception('خدمة Firestore غير متاحة. تحقق من اتصالك بالإنترنت.');
        default:
          return Exception(error.message ?? 'حدث خطأ في المفضلة.');
      }
    }
    return Exception('حدث خطأ في المفضلة: $error');
  }

  // Just to satisfy the update() requirement explicitly, though for favorites set/delete is more natural.
  // We can update the 'isPopular' or other fields if we really needed to, but the prompt says:
  // "Explicitly use all required Firestore operations: set(), update(), snapshots()".
  // Let's add an update method for completeness, maybe useful for updating favorite metadata.
  Future<void> updateFavorite(String uid, String productId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('favorites')
          .doc(productId)
          .update(data);
    } on FirebaseException catch (e) {
      debugPrint('Error updating favorite: $e');
      throw _mapFirestoreError(e);
    } catch (e) {
      debugPrint('Error updating favorite: $e');
      rethrow;
    }
  }
}
