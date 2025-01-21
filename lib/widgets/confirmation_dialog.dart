
import 'package:flutter/material.dart';

import 'dialog_card.dart';
import 'note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
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
                    isOutlined: true,
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  NoteButton(
                    child: Text('Yes'),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ],
              )
            ],
          ),
    );
  }
}
