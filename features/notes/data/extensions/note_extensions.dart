import '../../domain/entities/note.dart';
import '../models/note_model.dart';

extension NoteToModel on Note {
  NoteModel toModel() {
    return NoteModel(
      id: id,
      title: title,
      content: content,
      color: color,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
}

extension NoteModelToEntity on NoteModel {
  Note toEntity() {
    return Note(
      id: id,
      title: title,
      content: content,
      color: color,
      createdAt: createdAt,
      updatedAt: updatedAt,
      userId: userId,
    );
  }
}

extension NoteListToModel on List<Note> {
  List<NoteModel> toModels() {
    return map((note) => note.toModel()).toList();
  }
}

extension NoteModelListToEntity on List<NoteModel> {
  List<Note> toEntities() {
    return map((model) => model.toEntity()).toList();
  }
}
