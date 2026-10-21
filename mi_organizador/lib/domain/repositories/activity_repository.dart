import '../models/activity.dart';

abstract class ActivityRepository {
  /// Obtiene todas las actividades almacenadas.
  Future<List<Activity>> getActivities();

  /// Almacena una nueva actividad y devuelve su ID autogenerado.
  Future<int> addActivity(Activity activity);

  /// Actualiza una actividad existente.
  Future<void> updateActivity(Activity activity);

  /// Elimina una actividad por su identificador primario.
  Future<void> deleteActivity(int id);
}
