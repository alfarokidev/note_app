import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/notes_notifier.dart';
import '../widgets/animated_note_card.dart';
import '../widgets/shimmer_note_card.dart';

import '../../../../core/widgets/async_value_widget.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(notesNotifierProvider);
    final previousNotes = ref.read(notesNotifierProvider).value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          IconButton(
            onPressed: () => ref.read(notesNotifierProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh',
          ),
          IconButton(
            onPressed: () =>
                ref.read(themeNotifierProvider.notifier).toggleTheme(),
            icon: const Icon(Icons.brightness_6_rounded),
            tooltip: 'Toggle Theme',
          ),
          IconButton(
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Sign Out',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AsyncValueWidget(
        value: notesAsync,
        loading: _buildShimmerLoading(previousNotes.length),
        data: (notes) {
          if (notes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.note_add_outlined,
                      size: 48,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No notes yet',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to create your first note',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final note = notes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnimatedNoteCard(
                        note: note,
                        index: index,
                        onTap: () =>
                            context.push('${AppRouter.editNote}?id=${note.id}'),
                        onDelete: () =>
                            _showDeleteDialog(context, ref, note.id),
                      ),
                    );
                  }, childCount: notes.length),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRouter.createNote),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Note'),
      ),
    );
  }

  Widget _buildShimmerLoading(int itemCount) {
    final shimmerCount = itemCount > 0 ? itemCount : 3;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: ShimmerNoteCard(),
              ),
              childCount: shimmerCount,
            ),
          ),
        ),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref, String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(notesNotifierProvider.notifier).deleteNote(noteId);
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
