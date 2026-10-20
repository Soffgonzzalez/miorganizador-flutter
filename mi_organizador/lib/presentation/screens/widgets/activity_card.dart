import 'package:flutter/material.dart';
import '../../../domain/models/activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final ValueChanged<ActivityStatus> onStatusChanged;
  final VoidCallback onDelete;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.onStatusChanged,
    required this.onDelete,
  });

  Color _getStatusColor(ActivityStatus status) {
    switch (status) {
      case ActivityStatus.pending:
        return Colors.orange;
      case ActivityStatus.inProgress:
        return Colors.blue;
      case ActivityStatus.completed:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(activity.status);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    activity.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor),
                  ),
                  child: Text(
                    activity.status.label,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              activity.description,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha: ${activity.date.day}/${activity.date.month}/${activity.date.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Row(
                  children: [
                    PopupMenuButton<ActivityStatus>(
                      icon: const Icon(Icons.edit_note, size: 20),
                      tooltip: 'Cambiar Estado',
                      onSelected: onStatusChanged,
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: ActivityStatus.pending,
                          child: Text('Pendiente'),
                        ),
                        const PopupMenuItem(
                          value: ActivityStatus.inProgress,
                          child: Text('En Progreso'),
                        ),
                        const PopupMenuItem(
                          value: ActivityStatus.completed,
                          child: Text('Completada'),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                        size: 20,
                      ),
                      tooltip: 'Eliminar',
                      onPressed: onDelete,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
