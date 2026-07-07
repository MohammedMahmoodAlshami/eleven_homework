import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../models/product.dart';
import '../../repositories/product_repository.dart';

class ProductsProvider extends ChangeNotifier {
  final ProductRepository _repository = ProductRepository();
  StreamSubscription<List<Product>>? _subscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  List<Product> _products = [];
  bool _isLoading = true;
  String? _errorMessage;
  bool _isOffline = false;

  ProductsProvider() {
    _initConnectivityListener();
  }

  List<Product> get products => [..._products];
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isOffline => _isOffline;

  void _initConnectivityListener() {
    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((results) {
      final offline = results.contains(ConnectivityResult.none);
      if (offline != _isOffline) {
        _isOffline = offline;
        notifyListeners();
      }
    });
  }

  void loadProducts({bool forceRefresh = false}) {
    if (forceRefresh) {
      _subscription?.cancel();
      _subscription = null;
      _errorMessage = null;
    }

    if (_subscription != null) return;

    _isLoading = true;
    notifyListeners();

    _subscription = _repository.getProductsStream().listen(
      (productList) {
        _products = productList;
        _isLoading = false;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = error is Exception
            ? error.toString().replaceAll('Exception: ', '')
            : error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
