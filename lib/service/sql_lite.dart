import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shopi/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String cartTable = 'cart';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'shopi.db');

    // Copy the pre-populated database from assets if it doesn't exist
    await _copyDatabase(path);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _copyDatabase(String path) async {
    if (await FileSystemEntity.type(path) == FileSystemEntityType.notFound) {
      // Only copy if the database doesn't exist
      ByteData data = await rootBundle.load(join('assets', 'shopi.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
    }
  }


  Future<void> addItemToCart(CartItem item) async {
    final db = await database;
    await db.insert(cartTable, item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $cartTable(
        id INTEGER PRIMARY KEY,
        name TEXT,
        price REAL,
        quantity INTEGER,
        image TEXT
      )
    ''');
  }

  Future<void> insertCartItem(CartItem cartItem) async {
    final db = await database;
    await db.insert(cartTable, cartItem.toMap());
  }
}
