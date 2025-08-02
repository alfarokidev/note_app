import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../usecases/get_notes.dart';
import '../usecases/add_note.dart';
import '../usecases/update_note.dart';
import '../usecases/delete_note.dart';
import '../usecases/clear_notes.dart';
import '../../data/providers/data_providers.dart';

part 'domain_providers.g.dart';

@riverpod
GetNotes getNotes(Ref ref) => GetNotes(ref.read(notesRepositoryProvider));

@riverpod
AddNote addNote(Ref ref) => AddNote(ref.read(notesRepositoryProvider));

@riverpod
UpdateNote updateNote(Ref ref) => UpdateNote(ref.read(notesRepositoryProvider));

@riverpod
DeleteNote deleteNote(Ref ref) => DeleteNote(ref.read(notesRepositoryProvider));

@riverpod
ClearNotes clearNotes(Ref ref) => ClearNotes(ref.read(notesRepositoryProvider));
