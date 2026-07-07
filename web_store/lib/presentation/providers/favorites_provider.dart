import 'dart:async';
import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../repositories/favorites_repository.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesRepository _repository = FavoritesRepository();
  StreamSubscription<List<Product>>? _subscription;

  String? _uid;
  String? _errorMessage;
  final Set<String> _favoriteIds = {};
  List<Product> _favorites = [];

  List<Product> get favorites => [..._favorites];
  String? get errorMessage => _errorMessage;

  void initLoadFavorites(String uid) {
    if (_uid == uid && _subscription != null) return;
    _uid = uid;
    _errorMessage = null;

    _subscription?.cancel();
    _subscription = _repository.getFavoritesStream(uid).listen(
      (favoritesList) {
        _favorites = favoritesList;
        _favoriteIds
          ..clear()
          ..addAll(favoritesList.map((product) => product.id));
        _errorMessage = null;
        notifyListeners();
      },
      onError: (Object error) {
        _errorMessage = error is Exception
            ? error.toString().replaceAll('Exception: ', '')
            : error.toString();
        notifyListeners();
      },
    );
  }

  void clearFavorites() {
    _uid = null;
    _errorMessage = null;
    _subscription?.cancel();
    _subscription = null;
    _favorites.clear();
    _favoriteIds.clear();
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteIds.contains(product.id);
  }

  Future<void> toggleFavorite(Product product) async {
    if (_uid == null) return;

    final wasFavorite = isFavorite(product);

    if (wasFavorite) {
      _favoriteIds.remove(product.id);
      _favorites.removeWhere((p) => p.id == product.id);
      notifyListeners();

      try {
        await _repository.removeFavorite(_uid!, product.id);
      } catch (e) {
        _favoriteIds.add(product.id);
        _favorites.add(product);
        _errorMessage = e is Exception
            ? e.toString().replaceAll('Exception: ', '')
            : e.toString();
        notifyListeners();
      }
    } else {
      _favoriteIds.add(product.id);
      _favorites.add(product);
      notifyListeners();

      try {
        await _repository.addFavorite(_uid!, product);
      } catch (e) {
        _favoriteIds.remove(product.id);
        _favorites.removeWhere((p) => p.id == product.id);
        _errorMessage = e is Exception
            ? e.toString().replaceAll('Exception: ', '')
            : e.toString();
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
