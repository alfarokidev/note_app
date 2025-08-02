import 'package:either_dart/either.dart';

import '../repositories/notes_repository.dart';
import '../../../../core/error/failures.dart';

class ClearNotes {
  final NotesRepository repository;

  ClearNotes(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.clearNotes();
  }
}