import 'package:either_dart/either.dart';

import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';
import '../datasources/notes_remote_datasource.dart';

import '../extensions/note_extensions.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Note>>> getNotes() async {
    try {
      final remoteNotes = await remoteDataSource.getNotes();
      await localDataSource.cacheNotes(remoteNotes);
      return Right(remoteNotes.toEntities());
    } on FirestoreException {
      try {
        final cachedNotes = await localDataSource.getCachedNotes();
        return Right(cachedNotes.toEntities());
      } catch (cacheError) {
        return const Right([]);
      }
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Note>> addNote(Note note) async {
    try {
      final noteModel = note.toModel();
      final noteId = await remoteDataSource.addNote(noteModel);
      final createdNote = noteModel.copyWith(id: noteId);
      await localDataSource.addCachedNote(createdNote);
      return Right(createdNote.toEntity());
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(Note note) async {
    try {
      final noteModel = note.toModel();
      await remoteDataSource.updateNote(noteModel);
      await localDataSource.updateCachedNote(noteModel);
      return const Right(null);
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(String noteId) async {
    try {
      await remoteDataSource.removeNote(noteId);
      await localDataSource.removeCachedNote(noteId);
      return const Right(null);
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearNotes() async {
    try {
      await remoteDataSource.clearNotes();
      await localDataSource.clearCachedNotes();
      return const Right(null);
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
