import 'package:flutter_test/flutter_test.dart';
import 'package:web_store/models/product.dart';
import 'package:web_store/presentation/providers/cart_provider.dart';

void main() {
  final sampleProduct = Product(
    id: 'p1',
    name: 'Test Product',
    price: 100,
    description: 'Test description',
    imageUrl: 'assets/images/Phone1.jpg',
    categoryId: '1',
    categoryName: 'Electronics',
  );

  test('CartProvider adds, updates, and removes items', () {
    final cartProvider = CartProvider();

    cartProvider.addToCart(sampleProduct);
    expect(cartProvider.itemCount, 1);
    expect(cartProvider.totalAmount, 100);

    cartProvider.addToCart(sampleProduct);
    expect(cartProvider.itemCount, 2);
    expect(cartProvider.totalAmount, 200);

    cartProvider.removeOneFromCart(sampleProduct.id);
    expect(cartProvider.itemCount, 1);

    cartProvider.removeFromCart(sampleProduct.id);
    expect(cartProvider.itemCount, 0);
    expect(cartProvider.items, isEmpty);
  });
}
