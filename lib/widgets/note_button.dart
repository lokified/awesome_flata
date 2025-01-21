import 'package:flutter/material.dart';

import '../core/constants.dart';

class NoteButton extends StatelessWidget {
  const NoteButton(
      {super.key,
      required this.child, this.isOutlined = false,
      this.onPressed});

  final Widget child;
  final bool isOutlined;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(offset: Offset(2, 2), color: isOutlined ? primary : black)
      ], borderRadius: BorderRadius.circular(8)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: isOutlined ? white : primary,
            foregroundColor: isOutlined ? primary : white,
            disabledBackgroundColor: gray300,
            disabledForegroundColor: black,
            side: BorderSide(
              color: black,
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 0,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        child: child,
      ),
    );
  }
}
