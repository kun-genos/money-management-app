import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('money_management.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE categories(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      isExpense INTEGER NOT NULL
    )
    ''');

    await db.execute('''
    CREATE TABLE transactions(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      amount REAL NOT NULL,
      description TEXT,
      categoryId INTEGER,
      date TEXT NOT NULL,
      isExpense INTEGER NOT NULL,
      FOREIGN KEY (categoryId) REFERENCES categories(id)
    )
    ''');
  }

  Future<int> createCategory(String name, bool isExpense) async {
    final db = await instance.database;
    final data = {'name': name, 'isExpense': isExpense ? 1 : 0};
    return await db.insert('categories', data);
  }

  Future<List<Map<String, dynamic>>> getCategories(bool isExpense) async {
    final db = await instance.database;
    return await db.query(
      'categories',
      where: 'isExpense = ?',
      whereArgs: [isExpense ? 1 : 0],
    );
  }

  Future<int> deleteCategory(int id) async {
    final db = await instance.database;
    return await db.delete(
      'categories',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> createTransaction(double amount, String description,
      int categoryId, DateTime date, bool isExpense) async {
    final db = await instance.database;
    final data = {
      'amount': amount,
      'description': description,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'isExpense': isExpense ? 1 : 0,
    };
    return await db.insert('transactions', data);
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await instance.database;
    return await db.rawQuery('''
    SELECT t.*, c.name as categoryName
    FROM transactions t
    LEFT JOIN categories c ON t.categoryId = c.id
    ORDER BY t.date DESC
    ''');
  }

  Future<int> deleteTransaction(int id) async {
    final db = await instance.database;
    return await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
