import 'package:either_dart/either.dart';

import '../entities/note.dart';
import '../repositories/notes_repository.dart';
import '../../../../core/error/failures.dart';

class UpdateNote {
  final NotesRepository repository;

  UpdateNote(this.repository);

  Future<Either<Failure, void>> call(Note note) async {
    return await repository.updateNote(note);
  }
}