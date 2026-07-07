import 'dart:developer' as developer;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/cart_item.dart';

class CartDatabaseService {
  static final CartDatabaseService instance = CartDatabaseService._init();
  static Database? _database;

  CartDatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    developer.log('Initializing database at $path', name: 'CartDatabaseService');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';
    const realType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE cartItems (
  id $idType,
  productId $textType UNIQUE,
  title $textType,
  description $textType,
  image $textType,
  price $realType,
  quantity $integerType
)
''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    developer.log('Upgrading database from $oldVersion to $newVersion', name: 'CartDatabaseService');
    // Implement migration logic here when versions change
  }

  Future<void> insertCartItem(CartItem item) async {
    final db = await instance.database;
    try {
      await db.transaction((txn) async {
        await txn.insert(
          'cartItems',
          item.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      });
      developer.log('Inserted item: ${item.id}', name: 'CartDatabaseService');
    } catch (e) {
      developer.log('Error inserting item: $e', name: 'CartDatabaseService', error: e);
      rethrow;
    }
  }

  Future<void> updateCartItem(CartItem item) async {
    final db = await instance.database;
    try {
      await db.transaction((txn) async {
        await txn.update(
          'cartItems',
          item.toMap(),
          where: 'id = ?',
          whereArgs: [item.id],
        );
      });
      developer.log('Updated item: ${item.id}', name: 'CartDatabaseService');
    } catch (e) {
      developer.log('Error updating item: $e', name: 'CartDatabaseService', error: e);
      rethrow;
    }
  }

  Future<void> deleteCartItem(String id) async {
    final db = await instance.database;
    try {
      await db.transaction((txn) async {
        await txn.delete(
          'cartItems',
          where: 'id = ?',
          whereArgs: [id],
        );
      });
      developer.log('Deleted item: $id', name: 'CartDatabaseService');
    } catch (e) {
      developer.log('Error deleting item: $e', name: 'CartDatabaseService', error: e);
      rethrow;
    }
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    try {
      await db.transaction((txn) async {
        await txn.delete('cartItems');
      });
      developer.log('Cleared cart', name: 'CartDatabaseService');
    } catch (e) {
      developer.log('Error clearing cart: $e', name: 'CartDatabaseService', error: e);
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> readAllCartItems() async {
    final db = await instance.database;
    try {
      final result = await db.query('cartItems');
      return result;
    } catch (e) {
      developer.log('Error reading cart items: $e', name: 'CartDatabaseService', error: e);
      rethrow;
    }
  }

  Future<void> close() async {
    final db = await instance.database;
    await db.close();
  }
}
