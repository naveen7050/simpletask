class Task {
  final int? id;
  final String title;
  final String? details;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isDone;

  Task({
    this.id,
    required this.title,
    this.details,
    required this.createdAt,
    required this.updatedAt,
    this.isDone = false,
  });

  Task copyWith({
    int? id,
    String? title,
    String? details,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isDone,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDone: isDone ?? this.isDone,
    );
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      details: map['details'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      isDone: map['isDone'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isDone': isDone ? 1 : 0,
    };
  }
}
