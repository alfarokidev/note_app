import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/note_model.dart';

abstract class NotesLocalDataSource {
  Future<List<NoteModel>> getCachedNotes();
  Future<void> cacheNotes(List<NoteModel> notes);
  Future<void> addCachedNote(NoteModel note);
  Future<void> updateCachedNote(NoteModel note);
  Future<void> removeCachedNote(String noteId);
  Future<void> clearCachedNotes();
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  static const String _cachedNotesKey = 'cached_notes';
  final SharedPreferences sharedPreferences;

  NotesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<NoteModel>> getCachedNotes() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedNotesKey);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList
            .cast<Map<String, dynamic>>()
            .map((json) => NoteModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw CacheException(message: 'Failed to get cached notes: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheNotes(List<NoteModel> notes) async {
    try {
      final jsonList = notes.map((note) => note.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(_cachedNotesKey, jsonString);
    } catch (e) {
      throw CacheException(message: 'Failed to cache notes: ${e.toString()}');
    }
  }

  @override
  Future<void> addCachedNote(NoteModel note) async {
    try {
      final notes = await getCachedNotes();
      notes.add(note);
      await cacheNotes(notes);
    } catch (e) {
      throw CacheException(message: 'Failed to add cached note: ${e.toString()}');
    }
  }

  @override
  Future<void> updateCachedNote(NoteModel note) async {
    try {
      final notes = await getCachedNotes();
      final index = notes.indexWhere((n) => n.id == note.id);
      if (index != -1) {
        notes[index] = note;
        await cacheNotes(notes);
      }
    } catch (e) {
      throw CacheException(message: 'Failed to update cached note: ${e.toString()}');
    }
  }

  @override
  Future<void> removeCachedNote(String noteId) async {
    try {
      final notes = await getCachedNotes();
      notes.removeWhere((note) => note.id == noteId);
      await cacheNotes(notes);
    } catch (e) {
      throw CacheException(message: 'Failed to remove cached note: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCachedNotes() async {
    try {
      await sharedPreferences.remove(_cachedNotesKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear cached notes: ${e.toString()}');
    }
  }
}