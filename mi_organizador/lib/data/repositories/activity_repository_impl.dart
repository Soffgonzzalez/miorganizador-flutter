import '../../domain/models/activity.dart';
import '../../domain/repositories/activity_repository.dart';
import '../database/sqlite_database.dart';

class ActivityRepositoryImpl implements ActivityRepository {
  final SqliteDatabase _dbSource;

  ActivityRepositoryImpl({SqliteDatabase? dbSource})
    : _dbSource = dbSource ?? SqliteDatabase.instance;

  @override
  Future<List<Activity>> getActivities() async {
    final db = await _dbSource.database;
    // Consulta todos los registros ordenados por id descendente (las más recientes primero)
    final result = await db.query('activities', orderBy: 'id DESC');

    return result.map((map) => Activity.fromMap(map)).toList();
  }

  @override
  Future<int> addActivity(Activity activity) async {
    final db = await _dbSource.database;
    // SQLite omite la clave 'id' nula y autogenera el valor
    final id = await db.insert('activities', activity.toMap()..remove('id'));
    return id;
  }

  @override
  Future<void> updateActivity(Activity activity) async {
    final db = await _dbSource.database;
    await db.update(
      'activities',
      activity.toMap(),
      where: 'id = ?',
      whereArgs: [activity.id],
    );
  }

  @override
  Future<void> deleteActivity(int id) async {
    final db = await _dbSource.database;
    await db.delete('activities', where: 'id = ?', whereArgs: [id]);
  }
}
