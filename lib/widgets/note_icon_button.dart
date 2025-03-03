import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/constants.dart';

class NoteIconButton extends StatelessWidget {
  const NoteIconButton({
    super.key,
    required this.icon,
    this.size, required this.onPressed
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: FaIcon(icon),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: BoxConstraints(),
      style:
          IconButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      iconSize: size,
      color: gray700,
    );
  }
}
