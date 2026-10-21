import 'package:flutter/material.dart';
import '../../../domain/models/activity.dart';
import './widgets/activity_card.dart';
import 'new_activity_screen.dart';
import '../../domain/repositories/activity_repository.dart';
import '../../data/repositories/activity_repository_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ActivityRepository _repository = ActivityRepositoryImpl();

  // Lista dinámica de actividades en memoria
  List<Activity> _activities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  /// Carga inicial desde la base de datos SQLite
  Future<void> _loadActivities() async {
    setState(() => _isLoading = true);
    try {
      final loaded = await _repository.getActivities();
      setState(() {
        _activities = loaded;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cargar actividades: $e')),
        );
      }
    }
  }

  /// Create: Guarda en SQLite y recarga la interfaz
  Future<void> _navigateAndAddActivity() async {
    final newActivity = await Navigator.push<Activity>(
      context,
      MaterialPageRoute(builder: (context) => const NewActivityScreen()),
    );

    if (newActivity != null) {
      await _repository.addActivity(newActivity);
      await _loadActivities();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Actividad guardada permanentemente en la base de datos.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  /// Update: Actualiza en SQLite y recarga
  Future<void> _toggleStatus(Activity activity) async {
    final ActivityStatus nextStatus;
    switch (activity.status) {
      case ActivityStatus.pending:
        nextStatus = ActivityStatus.inProgress;
        break;
      case ActivityStatus.inProgress:
        nextStatus = ActivityStatus.completed;
        break;
      case ActivityStatus.completed:
        nextStatus = ActivityStatus.pending;
        break;
    }

    final updated = activity.copyWith(status: nextStatus);
    await _repository.updateActivity(updated);
    await _loadActivities();
  }

  /// Delete: Elimina de SQLite tras confirmación
  Future<void> _confirmDelete(Activity activity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar actividad'),
        content: Text(
          '¿Está seguro de eliminar "${activity.title}"? Esta acción no se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmed == true && activity.id != null) {
      await _repository.deleteActivity(activity.id!);
      await _loadActivities();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Actividad eliminada de la base de datos.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MiOrganizador'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar datos',
            onPressed: _loadActivities,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _activities.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.assignment_outlined,
                    size: 72,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay actividades registradas',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Presiona el botón + para crear la primera.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return ActivityCard(
                  activity: activity,
                  onStatusChanged: (newStatus) => _toggleStatus(activity),
                  onDelete: () => _confirmDelete(activity),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateAndAddActivity,
        icon: const Icon(Icons.add),
        label: const Text('Nueva Actividad'),
      ),
    );
  }
}
