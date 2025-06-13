class Note {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;

  Note({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
  });
}
