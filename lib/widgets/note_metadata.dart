
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/new_note_controller.dart';
import '../core/constants.dart';
import '../core/dialogs.dart';
import '../core/utils.dart';
import '../models/note.dart';
import 'note_icon_button.dart';
import 'note_tag.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({super.key, required this.note});

  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {

  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read<NewNoteController>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Last Modified',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: gray500),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(toLongDate(widget.note!.dateModified),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: gray900)))
            ],
          ),
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    'Created',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: gray500),
                  )),
              Expanded(
                  flex: 5,
                  child: Text(toLongDate(widget.note!.dateCreated),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: gray900)))
            ],
          ),
        ],
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Text(
                    'Tags',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: gray500),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  NoteIconButton(
                      icon: FontAwesomeIcons.circlePlus,
                      onPressed: () async {
                        final String? tag = await showNewTagDialog(context: context);

                        if (tag != null) {
                          newNoteController.addTag(tag);
                        }
                      }),
                ],
              ),
            ),
            Expanded(
                flex: 5,
                child: Selector<NewNoteController, List<String>>(
                    selector: (_, newNoteController) =>
                    newNoteController.tags,
                    builder: (_, tags, child) =>
                    tags.isEmpty
                        ? Text('No tags added',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: gray900))
                        : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            tags.length,
                                (index) =>
                                NoteTag(
                                  label: tags[index],
                                  onTap: () async {
                                    final String? tag = await showNewTagDialog(context: context, tag: tags[index]);

                                    if (tag != null && tag != tags[index]) {
                                      newNoteController.updateTag(tag, index);
                                    }
                                  },
                                  onClose: () {
                                    newNoteController
                                        .removeTag(index);
                                  },
                                )),
                      ),
                    ))),
          ],
        ),
      ],
    );
  }
}
