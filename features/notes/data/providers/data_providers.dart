import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasources/notes_local_datasource.dart';
import '../datasources/notes_remote_datasource.dart';
import '../repositories/notes_repository_impl.dart';
import '../../domain/repositories/notes_repository.dart';

part 'data_providers.g.dart';

@riverpod
FirebaseFirestore firebaseFirestore(Ref ref) {
  return FirebaseFirestore.instance;
}

@riverpod
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@riverpod
SharedPreferences sharedPreferences(Ref ref) =>
    throw UnimplementedError('it must be overridden');

@riverpod
NotesRemoteDataSource notesRemoteDataSource(Ref ref) {
  return NotesRemoteDataSourceImpl(
    firestore: ref.read(firebaseFirestoreProvider),
    firebaseAuth: ref.read(firebaseAuthProvider),
  );
}

@riverpod
NotesLocalDataSource notesLocalDataSource(Ref ref) => NotesLocalDataSourceImpl(
  sharedPreferences: ref.read(sharedPreferencesProvider),
);

@riverpod
NotesRepository notesRepository(Ref ref) {
  final remoteDataSource = ref.read(notesRemoteDataSourceProvider);
  final localDataSource = ref.read(notesLocalDataSourceProvider);

  return NotesRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
  );
}
