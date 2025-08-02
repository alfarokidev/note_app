import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/data/datasources/firebase_remote_datasource.dart';
import '../../../../core/error/exceptions.dart';
import '../models/note_model.dart';

abstract class NotesRemoteDataSource {
  Future<List<NoteModel>> getNotes();
  Future<String> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> removeNote(String noteId);
  Future<void> clearNotes();
}

class NotesRemoteDataSourceImpl extends FirebaseRemoteDataSource
    implements NotesRemoteDataSource {
  static const String _notesCollection = 'notes';

  NotesRemoteDataSourceImpl({
    required super.firestore,
    required super.firebaseAuth,
  });

  @override
  Future<List<NoteModel>> getNotes() async {
    try {
      final userId = getCurrentUserId();
      final documents = await getDocuments(
        collection: _notesCollection,
        queryBuilder: (collection) =>
            collection.where('userId', isEqualTo: userId),
      );
      return documents.map((doc) => NoteModel.fromFirestore(doc)).toList();
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirestore(e);
    }
  }

  @override
  Future<String> addNote(NoteModel note) async {
    try {
      return await createDocument(
        collection: _notesCollection,
        documentId: null,
        data: note.copyWith(userId: getCurrentUserId()).toJson(),
      );
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirestore(e);
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    try {
      await updateDocument(
        collection: _notesCollection,
        documentId: note.id,
        data: note.copyWith(userId: getCurrentUserId()).toJson(),
      );
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirestore(e);
    }
  }

  @override
  Future<void> removeNote(String noteId) async {
    try {
      await deleteDocument(collection: _notesCollection, documentId: noteId);
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirestore(e);
    }
  }

  @override
  Future<void> clearNotes() async {
    try {
      final notes = await getNotes();
      final noteIds = notes.map((note) => note.id).toList();

      if (noteIds.isNotEmpty) {
        await batchDeleteDocuments(
          collection: _notesCollection,
          documentIds: noteIds,
        );
      }
    } on FirebaseException catch (e) {
      throw FirestoreException.fromFirestore(e);
    }
  }
}
