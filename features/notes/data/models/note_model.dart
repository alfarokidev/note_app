// ignore_for_file: public_member_api_docs, sort_constructors_first
class NoteModel {
  final String id;
  final String title;
  final String content;
  final int color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      color: json['color'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'userId': userId,
    };
  }

  factory NoteModel.fromFirestore(Map<String, dynamic> data) {
    return NoteModel(
      id: data['id'] as String,
      title: data['title'] as String,
      content: data['content'] as String,
      color: data['color'] as int,
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
      userId: data['userId'] as String,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'color': color,
      'userId': userId,
    };
  }

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    int? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }

  // Factory for creating new note
  factory NoteModel.create({
    required String title,
    required String content,
    required int color,
    required String userId,
  }) {
    final now = DateTime.now();
    return NoteModel(
      id: now.millisecondsSinceEpoch.toString(),
      title: title.isEmpty ? 'Untitled' : title,
      content: content,
      color: color,
      createdAt: now,
      updatedAt: now,
      userId: userId,
    );
  }

  // Update existing note
  NoteModel update({String? title, String? content, int? color}) {
    return copyWith(
      title: title,
      content: content,
      color: color,
      updatedAt: DateTime.now(),
    );
  }

  // Check if note is empty
  bool get isEmpty => title.trim().isEmpty && content.trim().isEmpty;

  // Get preview text
  String get preview {
    if (content.isEmpty) return 'No content';
    return content.length > 100 ? '${content.substring(0, 100)}...' : content;
  }

  // Check if recently updated (within last hour)
  bool get isRecentlyUpdated {
    final now = DateTime.now();
    return now.difference(updatedAt).inHours < 1;
  }
}
