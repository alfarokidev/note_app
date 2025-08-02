import 'package:flutter/material.dart';

import '../../domain/entities/note.dart';
import 'note_card.dart';

class AnimatedNoteCard extends StatefulWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final int index;

  const AnimatedNoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onDelete,
    required this.index,
  });

  @override
  State<AnimatedNoteCard> createState() => _AnimatedNoteCardState();
}

class _AnimatedNoteCardState extends State<AnimatedNoteCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300 + (widget.index * 100)),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: NoteCard(
                note: widget.note,
                onTap: widget.onTap,
                onDelete: widget.onDelete,
              ),
            ),
          ),
        );
      },
    );
  }
}
