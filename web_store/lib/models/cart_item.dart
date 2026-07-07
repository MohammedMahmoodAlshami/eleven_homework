import 'package:equatable/equatable.dart';
import 'package:web_store/models/product.dart';

class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  CartItem copyWith({
    String? id,
    Product? product,
    int? quantity,
  }) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': product.id,
      'title': product.name,
      'description': product.description,
      'image': product.imageUrl,
      'price': product.price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map, Product product) {
    return CartItem(
      id: map['id']?.toString() ?? '',
      product: product,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity];
}
