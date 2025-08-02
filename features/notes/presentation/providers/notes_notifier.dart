import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/note.dart';
import '../../domain/providers/domain_providers.dart';

part 'notes_notifier.g.dart';

@riverpod
class NotesNotifier extends _$NotesNotifier {
  @override
  Future<List<Note>> build() async {
    return _getNotes();
  }

  Future<List<Note>> _getNotes() async {
    // Add delay to show shimmer loading
    await Future.delayed(const Duration(seconds: 1));

    final useCase = await ref.read(getNotesProvider);
    final result = await useCase();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (notes) => notes,
    );
  }

  Future<void> addNote(Note note) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = await ref.read(addNoteProvider);
      final result = await useCase(note);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (_) => _getNotes(),
      );
    });
  }

  Future<void> updateNote(Note note) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = await ref.read(updateNoteProvider);
      final result = await useCase(note);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (_) => _getNotes(),
      );
    });
  }

  Future<void> deleteNote(String noteId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = await ref.read(deleteNoteProvider);
      final result = await useCase(noteId);
      return result.fold(
        (failure) => throw Exception(failure.message),
        (_) => _getNotes(),
      );
    });
  }

  Future<void> clearNotes() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final useCase = await ref.read(clearNotesProvider);
      final result = await useCase();
      return result.fold(
        (failure) => throw Exception(failure.message),
        (_) => _getNotes(),
      );
    });
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getNotes();
    });
  }
}
