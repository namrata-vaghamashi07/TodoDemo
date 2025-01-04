class Todo {
  int? id;
  String title;
  String description;
  String status; // 'TODO', 'In-Progress', 'Done'
  String timer; // Timer in seconds

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.timer,
  });

  // Convert Todo to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'timer': timer, // Store the timer as seconds
    };
  }

  // Convert Map to Todo
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'],
      timer: map['timer'],
    );
  }
}
