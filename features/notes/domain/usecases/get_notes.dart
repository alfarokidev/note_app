import 'package:either_dart/either.dart';

import '../entities/note.dart';
import '../repositories/notes_repository.dart';
import '../../../../core/error/failures.dart';

class GetNotes {
  final NotesRepository repository;

  GetNotes(this.repository);

  Future<Either<Failure, List<Note>>> call() async {
    return await repository.getNotes();
  }
}