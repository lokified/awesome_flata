import 'package:flutter/material.dart';

import '../core/constants.dart';

class NoteTag extends StatelessWidget {
  const NoteTag({super.key, required this.label, this.onTap, this.onClose});

  final String label;
  final VoidCallback? onClose;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: gray100),
        padding: EdgeInsets.symmetric(
            vertical: 2, horizontal: 12),
        margin: EdgeInsets.only(right: 4),
        child: Row(
          children:[ Text(
            label,
            style: TextStyle(fontSize: onClose != null ? 14 : 12, color: gray700),
          ),
          if (onClose != null) ...[
            SizedBox(width: 4,),
            GestureDetector(
              onTap: onClose,
              child: Icon(Icons.close, size: 18,),
            )
          ]
          ]
        ),
      ),
    );
  }
}
