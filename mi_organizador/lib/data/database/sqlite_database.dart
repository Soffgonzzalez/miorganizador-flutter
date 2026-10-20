import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabase {
  // Implementación del Patrón Singleton
  static final SqliteDatabase instance = SqliteDatabase._init();
  static Database? _database;

  SqliteDatabase._init();

  /// Obtiene la instancia activa de la base de datos o la inicializa si es la primera vez.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('miorganizador.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// Creación del esquema relacional DDL al ejecutar por primera vez
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE activities (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        date TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  /// Cierra la conexión de base de datos
  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
