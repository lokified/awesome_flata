import 'package:flutter/material.dart';
import 'package:tutsi/widgets/dialog_card.dart';
import 'package:tutsi/widgets/note_form_field.dart';

import '../core/constants.dart';
import 'note_button.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({super.key, this.tag});

  final String? tag;

  @override
  State<NewTagDialog> createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late final TextEditingController tagController;
  late final GlobalKey<FormFieldState> tagKey;

  @override
  void initState() {
    super.initState();
    tagController = TextEditingController(text: widget.tag);
    tagKey = GlobalKey();
  }

  @override
  void dispose() {
    tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 32,
          ),
          NoteFormField(
            key: tagKey,
            controller: tagController,
            autofocus: true,
            hintText: 'Add tag (< 16 characters)',
            validator: (value) {
              if (value!.trim().isEmpty) {
                return 'No tags added';
              } else if (value.trim().length > 16) {
                return 'Tags should not be more than 16 characters';
              } else
                null;
            },
            onChanged: (newValue) {
              tagKey.currentState!.validate();
            },
          ),
          SizedBox(
            height: 24,
          ),
          DecoratedBox(
              decoration: BoxDecoration(
                  boxShadow: [BoxShadow(offset: Offset(2, 2), color: black)],
                  borderRadius: BorderRadius.circular(8)),
              child: NoteButton(
                child: Text('Add Tag'),
                onPressed: () {
                  if (tagKey.currentState?.validate() ?? false) {
                    Navigator.pop(context, tagController.text.trim());
                  }
                },
              ))
        ],
      ),
    );
  }
}
