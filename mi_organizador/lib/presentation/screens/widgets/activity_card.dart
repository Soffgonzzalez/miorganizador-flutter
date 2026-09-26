import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String status;

  const ActivityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.status,
  });

  Color _statusColor(BuildContext context) {
    switch (status.toLowerCase()) {
      case 'completada':
        return Colors.green;

      case 'en progreso':
        return Colors.orange;

      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(child: Icon(icon)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Chip(
          label: Text(status),
          backgroundColor: _statusColor(context),
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}