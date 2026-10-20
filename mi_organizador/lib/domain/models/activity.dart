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
  final int? id;
  final String title;
  final String description;
  final String date;
  final ActivityStatus status;

  const Activity({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    this.status = ActivityStatus.pending,
  });

  /// Crea una copia del objeto modificando únicamente los campos especificados.
  Activity copyWith({
    int? id,
    String? title,
    String? description,
    String? date,
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

  /// Mapeo Objeto -> Registro SQLite (Map<String, dynamic>)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'status': status.name, // Guarda 'pending', 'inProgress', 'completed'
    };
  }

  /// Mapeo Registro SQLite -> Objeto Dart
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String,
      date: map['date'] as String,
      status: ActivityStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => ActivityStatus.pending,
      ),
    );
  }
}
