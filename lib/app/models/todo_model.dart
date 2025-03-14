class Todo {
  int? id;
  String title;
  String description;
  bool isCompleted;
  int userId;
  DateTime deadline;

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.userId,
    required this.deadline,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'user_id': userId,
      'deadline': deadline.toIso8601String(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      userId: map['user_id'],
      deadline: DateTime.parse(map['deadline']),
    );
  }

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    int? userId,
    DateTime? deadline,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
      deadline: deadline ?? this.deadline,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo && runtimeType == other.runtimeType && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
