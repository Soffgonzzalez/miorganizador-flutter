import 'package:flutter/material.dart';
import '../../models/activity.dart';
import 'new_activity_screen.dart';
import 'widgets/activity_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Lista dinámica de actividades en memoria
  final List<Activity> _activities = [
    Activity(
      id: '1',
      title: 'Estudiar Flutter',
      description: 'Repasar widgets, StatefulWidget y formulación de estado',
      date: DateTime.now(),
      status: ActivityStatus.pending,
    ),
  ];

  // CREATE: Navegar a NewActivityScreen y recibir la nueva actividad
  Future<void> _navigateAndCreateActivity() async {
    final newActivity = await Navigator.push<Activity>(
      context,
      MaterialPageRoute(builder: (context) => const NewActivityScreen()),
    );

    if (newActivity != null) {
      setState(() {
        _activities.add(newActivity);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Actividad "${newActivity.title}" agregada')),
        );
      }
    }
  }

  // UPDATE: Cambiar el estado de la actividad en la lista
  void _updateActivityStatus(int index, ActivityStatus newStatus) {
    setState(() {
      _activities[index] = _activities[index].copyWith(status: newStatus);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Estado actualizado a ${newStatus.label}')),
    );
  }

  // DELETE: Confirmar y eliminar actividad de la lista
  void _deleteActivity(int index) {
    final activityToDelete = _activities[index];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Actividad'),
        content: Text(
          '¿Desea eliminar la actividad "${activityToDelete.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _activities.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Actividad "${activityToDelete.title}" eliminada',
                  ),
                ),
              );
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MiOrganizador'), centerTitle: true),
      body: _activities.isEmpty
          ? const Center(
              child: Text(
                'No hay actividades registradas.\n¡Presiona + para crear una!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return ActivityCard(
                  activity: activity,
                  onStatusChanged: (newStatus) {
                    _updateActivityStatus(index, newStatus);
                  },
                  onDelete: () {
                    _deleteActivity(index);
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateAndCreateActivity,
        tooltip: 'Nueva Actividad',
        child: const Icon(Icons.add),
      ),
    );
  }
}
