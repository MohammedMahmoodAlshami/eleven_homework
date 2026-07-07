import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import '../../models/product.dart';
import '../../models/cart_item.dart';
import '../../repositories/cart_repository.dart';

class CartProvider extends ChangeNotifier {
  final CartRepository _cartRepository;
  
  Map<String, CartItem> _items = {};
  bool _isLoading = false;
  String? _errorMessage;

  CartProvider({CartRepository? cartRepository})
      : _cartRepository = cartRepository ?? CartRepository() {
    loadCartItems();
  }

  Map<String, CartItem> get items => {..._items};
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  int get itemCount => _items.values.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalAmount => _items.values.fold(
    0, (sum, item) => sum + (item.product.price * item.quantity),
  );

  Future<void> loadCartItems() async {
    _setLoading(true);
    try {
      final cartItemsList = await _cartRepository.getAllCartItems();
      _items = {for (var item in cartItemsList) item.id: item};
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load cart data.';
      developer.log('Error loading cart items: $e', name: 'CartProvider', error: e);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToCart(Product product) async {
    _clearError();
    final String productId = product.id;
    final bool exists = _items.containsKey(productId);
    
    try {
      if (exists) {
        final existingItem = _items[productId]!;
        final updatedItem = existingItem.copyWith(quantity: existingItem.quantity + 1);
        await _cartRepository.updateItemQuantity(updatedItem);
        _items[productId] = updatedItem;
      } else {
        final newItem = CartItem(id: productId, product: product, quantity: 1);
        await _cartRepository.addItem(newItem);
        _items[productId] = newItem;
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to add item to cart.';
      notifyListeners();
      developer.log('Error adding to cart: $e', name: 'CartProvider', error: e);
    }
  }

  Future<void> removeOneFromCart(String productId) async {
    if (!_items.containsKey(productId)) return;
    
    _clearError();
    final existingItem = _items[productId]!;
    
    try {
      if (existingItem.quantity > 1) {
        final updatedItem = existingItem.copyWith(quantity: existingItem.quantity - 1);
        await _cartRepository.updateItemQuantity(updatedItem);
        _items[productId] = updatedItem;
      } else {
        await _cartRepository.removeItem(productId);
        _items.remove(productId);
      }
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update item quantity.';
      notifyListeners();
      developer.log('Error removing one from cart: $e', name: 'CartProvider', error: e);
    }
  }

  Future<void> removeFromCart(String productId) async {
    if (!_items.containsKey(productId)) return;

    _clearError();
    try {
      await _cartRepository.removeItem(productId);
      _items.remove(productId);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to remove item from cart.';
      notifyListeners();
      developer.log('Error removing from cart: $e', name: 'CartProvider', error: e);
    }
  }

  Future<void> clearCart() async {
    _clearError();
    try {
      await _cartRepository.clearCart();
      _items.clear();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to clear cart.';
      notifyListeners();
      developer.log('Error clearing cart: $e', name: 'CartProvider', error: e);
    }
  }
  
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }
}
