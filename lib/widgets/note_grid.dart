

import 'package:flutter/material.dart';

import '../models/note.dart';
import 'note_card.dart';


class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.notes});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 4, mainAxisSpacing: 8),
      itemBuilder: (context, int index) {
        return NoteCard(
          isInGrid: true,
          note: notes[index],
        );
      },
    );
  }
}