import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/entry.dart';

/// Repository Pattern: Abstracts all database operations
/// Benefits: Easy to test, easy to switch databases later
class DatabaseRepository {
  static Database? _database;

  /// Singleton pattern - only one database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize and create the database
  Future<Database> _initDatabase() async {
    // Get the default database location
    String path = join(await getDatabasesPath(), 'mindful_journal.db');

    // Open/create database with version 1
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  /// Create the entries table
  /// Called only once when database is first created
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        aiInsight TEXT
      )
    ''');
  }

  /// INSERT: Add a new entry
  Future<int> insertEntry(Entry entry) async {
    final db = await database;

    // insert() returns the new row's ID
    return await db.insert(
      'entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// SELECT: Get all entries, newest first
  Future<List<Entry>> getAllEntries() async {
    final db = await database;

    // Query returns List<Map>
    final List<Map<String, dynamic>> maps = await db.query(
      'entries',
      orderBy: 'createdAt DESC', // Newest first
    );

    // Convert each Map to Entry object
    return List.generate(maps.length, (i) {
      return Entry.fromMap(maps[i]);
    });
  }

  /// SELECT: Get a single entry by ID
  Future<Entry?> getEntryById(int id) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      'entries',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isEmpty) return null;
    return Entry.fromMap(maps.first);
  }

  /// UPDATE: Modify an existing entry
  Future<int> updateEntry(Entry entry) async {
    final db = await database;

    return await db.update(
      'entries',
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  /// DELETE: Remove an entry
  Future<int> deleteEntry(int id) async {
    final db = await database;

    return await db.delete('entries', where: 'id = ?', whereArgs: [id]);
  }

  /// Close database connection (call on app shutdown)
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
