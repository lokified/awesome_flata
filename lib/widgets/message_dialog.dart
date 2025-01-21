
import 'package:flutter/material.dart';

import 'dialog_card.dart';
import 'note_button.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            message,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NoteButton(
                child: Text('Ok'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          )
        ],
      ),
    );
  }
}
