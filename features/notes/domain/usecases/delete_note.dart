import 'package:either_dart/either.dart';

import '../repositories/notes_repository.dart';
import '../../../../core/error/failures.dart';

class DeleteNote {
  final NotesRepository repository;

  DeleteNote(this.repository);

  Future<Either<Failure, void>> call(String noteId) async {
    return await repository.deleteNote(noteId);
  }
}