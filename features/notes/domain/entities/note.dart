import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String content;
  final int color;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  const Note({
    required this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    color,
    createdAt,
    updatedAt,
    userId,
  ];

  Note copyWith({
    String? id,
    String? title,
    String? content,
    int? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}
