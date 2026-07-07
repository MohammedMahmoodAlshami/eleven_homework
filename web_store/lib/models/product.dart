import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final String categoryId;
  final String categoryName;
  final bool isPopular;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.categoryId,
    required this.categoryName,
    this.isPopular = false,
  });

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? description,
    String? imageUrl,
    String? categoryId,
    String? categoryName,
    bool? isPopular,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      isPopular: isPopular ?? this.isPopular,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      name: json['title'] ?? json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      imageUrl: json['image'] ?? json['imageUrl'] ?? '',
      categoryId: json['categoryId']?.toString() ?? '1',
      categoryName: json['category'] ?? json['categoryName'] ?? 'General',
      isPopular: json['isPopular'] ?? false,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product.fromJson(map);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  factory Product.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Product(
      id: doc.id,
      name: data['name']?.toString() ?? '',
      price: _parseDouble(data['price']),
      description: data['description']?.toString() ?? '',
      imageUrl: data['imageUrl']?.toString() ?? '',
      categoryId: data['categoryId']?.toString() ?? '1',
      categoryName: data['categoryName']?.toString() ?? 'General',
      isPopular: _parseBool(data['isPopular']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static bool _parseBool(dynamic value) {
    if (value == null) return false;
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1';
    }
    return false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'isPopular': isPopular,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        description,
        imageUrl,
        categoryId,
        categoryName,
        isPopular,
      ];
}