import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/note.dart';
import '../../domain/enums/note_operation.dart';

import '../providers/notes_notifier.dart';
import '../widgets/color_picker.dart';
import '../../../../core/constants/note_colors.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EditNotePage extends ConsumerWidget {
  final String? noteId;

  const EditNotePage({super.key, this.noteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final selectedColor = ValueNotifier<int>(NoteColors.colors.first);
    final operation = noteId != null
        ? NoteOperation.update
        : NoteOperation.create;

    // Load existing note if updating
    if (operation.isUpdate) {
      final notesAsync = ref.watch(notesNotifierProvider);
      notesAsync.whenData((notes) {
        final note = notes.firstWhere((n) => n.id == noteId);
        titleController.text = note.title;
        contentController.text = note.content;
        selectedColor.value = note.color;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            operation.isUpdate ? 'Edit Note' : 'New Note',
            key: ValueKey(operation),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FilledButton.icon(
                    onPressed: () => _saveNote(
                      context,
                      ref,
                      titleController.text.trim(),
                      contentController.text.trim(),
                      selectedColor.value,
                      operation,
                    ),
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text('Save'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 600),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, 50 * (1 - value)),
            child: Opacity(
              opacity: value,
              child: Column(
                children: [
                  // Title Field
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: CustomTextField(
                      controller: titleController,
                      hintText: 'Note title',
                      prefixIcon: Icons.title_rounded,
                      isTitle: true,
                    ),
                  ),

                  // Content Field
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: CustomTextField(
                        controller: contentController,
                        hintText: 'Start writing your thoughts...',
                        prefixIcon: Icons.edit_note_rounded,
                        maxLines: null,
                        expands: true,
                      ),
                    ),
                  ),

                  // Color Picker Section
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    curve: Curves.elasticOut,
                    builder: (context, slideValue, child) {
                      return Transform.translate(
                        offset: Offset(0, 100 * (1 - slideValue)),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer.withOpacity(0.5),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                            border: Border(
                              top: BorderSide(
                                color: Theme.of(
                                  context,
                                ).colorScheme.outline.withOpacity(0.1),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TweenAnimationBuilder<double>(
                                    duration: const Duration(
                                      milliseconds: 1000,
                                    ),
                                    tween: Tween(begin: 0.0, end: 1.0),
                                    curve: Curves.bounceOut,
                                    builder: (context, iconValue, child) {
                                      return Transform.scale(
                                        scale: iconValue,
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.palette_rounded,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.primary,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    'Choose Color',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              ValueListenableBuilder<int>(
                                valueListenable: selectedColor,
                                builder: (context, color, _) {
                                  return ColorPicker(
                                    selectedColor: color,
                                    onColorSelected: (newColor) =>
                                        selectedColor.value = newColor,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _saveNote(
    BuildContext context,
    WidgetRef ref,
    String title,
    String content,
    int color,
    NoteOperation operation,
  ) {
    if (title.isEmpty && content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Please add some content'),
            ],
          ),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    if (operation.isUpdate) {
      final notesAsync = ref.read(notesNotifierProvider);
      notesAsync.whenData((notes) {
        final existingNote = notes.firstWhere((n) => n.id == noteId);
        final updatedNote = existingNote.copyWith(
          title: title,
          content: content,
          color: color,
        );
        ref.read(notesNotifierProvider.notifier).updateNote(updatedNote);
      });
    } else {
      final note = Note(
        title: title,
        content: content,
        color: color,
        userId: 'current-user',
        id: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      ref.read(notesNotifierProvider.notifier).addNote(note);
    }

    context.pop();
  }
}
