import 'dart:developer' as developer;
import '../models/cart_item.dart';
import '../models/product.dart';
import '../services/cart_database_service.dart';

class CartRepository {
  final CartDatabaseService _dbService;

  CartRepository({CartDatabaseService? dbService})
      : _dbService = dbService ?? CartDatabaseService.instance;

  Future<List<CartItem>> getAllCartItems() async {
    try {
      final maps = await _dbService.readAllCartItems();
      final List<CartItem> cartItems = [];
      for (var map in maps) {
        try {
          final product = Product(
            id: map['productId']?.toString() ?? '',
            name: map['title']?.toString() ?? '',
            price: (map['price'] as num?)?.toDouble() ?? 0.0,
            description: map['description']?.toString() ?? '',
            imageUrl: map['image']?.toString() ?? '',
            categoryId: '1', // default or ignored for cart context
            categoryName: 'General', // default or ignored for cart context
          );
          final cartItem = CartItem.fromMap(map, product);
          cartItems.add(cartItem);
        } catch (e) {
          developer.log('Error parsing cart item from db: $e', name: 'CartRepository', error: e);
        }
      }
      return cartItems;
    } catch (e) {
      developer.log('Error getting all cart items: $e', name: 'CartRepository', error: e);
      throw Exception('Failed to load cart items from database');
    }
  }

  Future<void> addItem(CartItem item) async {
    if (item.quantity <= 0) {
      throw ArgumentError('Quantity must be greater than zero.');
    }
    if (item.id.isEmpty || item.product.id.isEmpty) {
      throw ArgumentError('Item ID and Product ID cannot be empty.');
    }

    try {
      await _dbService.insertCartItem(item);
    } catch (e) {
      developer.log('Error adding item: $e', name: 'CartRepository', error: e);
      throw Exception('Failed to add item to database');
    }
  }

  Future<void> updateItemQuantity(CartItem item) async {
    if (item.quantity <= 0) {
      throw ArgumentError('Quantity must be greater than zero. Use delete instead.');
    }
    
    try {
      await _dbService.updateCartItem(item);
    } catch (e) {
      developer.log('Error updating item quantity: $e', name: 'CartRepository', error: e);
      throw Exception('Failed to update item in database');
    }
  }

  Future<void> removeItem(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('Item ID cannot be empty.');
    }

    try {
      await _dbService.deleteCartItem(id);
    } catch (e) {
      developer.log('Error removing item: $e', name: 'CartRepository', error: e);
      throw Exception('Failed to remove item from database');
    }
  }

  Future<void> clearCart() async {
    try {
      await _dbService.clearCart();
    } catch (e) {
      developer.log('Error clearing cart: $e', name: 'CartRepository', error: e);
      throw Exception('Failed to clear cart in database');
    }
  }
}
