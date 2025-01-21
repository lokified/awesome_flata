import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/new_note_controller.dart';
import '../change_notifiers/notes_provider.dart';
import '../core/constants.dart';
import '../core/dialogs.dart';
import '../core/utils.dart';
import '../models/note.dart';
import '../pages/new_or_edit_note_page.dart';
import 'note_tag.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.isInGrid,
    required this.note,
  });

  final bool isInGrid;
  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                    create: (_) => NewNoteController()..note = note,
                    child: NewOrEditNotePage(isNewNote: false))));
      },
      child: Container(
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: primary, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: primary.withOpacity(0.5), offset: Offset(4, 4))
            ]),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (note.title != null) ...[
              Text(
                note.title!,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, color: gray900),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
            SizedBox(
              height: 4,
            ),
            if (note.tags.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: List.generate(
                        note.tags.length,
                        (index) => NoteTag(
                              label: note.tags[index],
                            ))),
              ),
            ],
            SizedBox(
              height: 4,
            ),
            if (note.content != null)
              isInGrid
                  ? Expanded(
                      child: Text(
                      note.content!,
                      style: TextStyle(color: gray700),
                    ))
                  : Text(
                      note.content!,
                      style: TextStyle(color: gray700),
                      maxLines: 3,
                    ),
            if (isInGrid) Spacer(),
            Row(
              children: [
                Text(
                  toShortDate(note.dateModified),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete = await showConfirmationDialog(
                            context: context,
                            title: 'Do you want to delete the note?') ??
                        false;

                    if (shouldDelete && context.mounted) {
                      context.read<NotesProvider>().deleteNote(note);
                    }
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: gray500,
                    size: 16,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
