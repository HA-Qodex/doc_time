class Todo {
  final int id;
  final String title;
  final String subtitle;

  const Todo({required this.id, required this.title, required this.subtitle});

  Todo copyWith({required int id, String? title, String? subtitle}) {
    return Todo(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }
}
