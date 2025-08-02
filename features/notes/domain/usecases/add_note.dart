import 'package:either_dart/either.dart';

import '../entities/note.dart';
import '../repositories/notes_repository.dart';
import '../../../../core/error/failures.dart';

class AddNote {
  final NotesRepository repository;

  AddNote(this.repository);

  Future<Either<Failure, Note>> call(Note note) async {
    return await repository.addNote(note);
  }
}