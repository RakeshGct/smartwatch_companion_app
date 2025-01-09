import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance of DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Private constructor
  DatabaseHelper._init();

  // Getter for database instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('health_records.db');
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // Create the records table
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE records (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date TEXT NOT NULL,
        heartRate INTEGER NOT NULL,
        steps INTEGER NOT NULL
      )
    ''');
  }

  // Add a record to the database
  Future<int> addRecord(Map<String, dynamic> record) async {
    try {
      final db = await instance.database;
      return await db.insert('records', record);
    } catch (e) {
      print('Error adding record: $e');
      return -1; // Indicate an error
    }
  }

  // Fetch all records from the database
  Future<List<Map<String, dynamic>>> fetchRecords() async {
    try {
      final db = await instance.database;
      return await db.query(
        'records',
        orderBy: 'date DESC', // Sort records by date (newest first)
      );
    } catch (e) {
      print('Error fetching records: $e');
      return []; // Return an empty list on error
    }
  }

  // Close the database connection
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null; // Reset the database instance
    }
  }
}
