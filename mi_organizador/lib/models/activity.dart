enum ActivityStatus { pending, inProgress, completed }

extension ActivityStatusX on ActivityStatus {
  String get label {
    switch (this) {
      case ActivityStatus.pending:
        return 'Pendiente';
      case ActivityStatus.inProgress:
        return 'En Progreso';
      case ActivityStatus.completed:
        return 'Completada';
    }
  }
}

class Activity {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final ActivityStatus status;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
  });

  Activity copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    ActivityStatus? status,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
