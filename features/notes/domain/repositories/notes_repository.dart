import 'package:either_dart/either.dart';

import '../entities/note.dart';
import '../../../../core/error/failures.dart';

abstract class NotesRepository {
  Future<Either<Failure, List<Note>>> getNotes();
  Future<Either<Failure, Note>> addNote(Note note);
  Future<Either<Failure, void>> updateNote(Note note);
  Future<Either<Failure, void>> deleteNote(String noteId);
  Future<Either<Failure, void>> clearNotes();
}