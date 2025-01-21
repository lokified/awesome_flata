
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/notes_provider.dart';
import '../core/constants.dart';
import '../core/enums/order_option.dart';
import 'note_icon_button.dart';

class ViewOptions extends StatefulWidget {
  const ViewOptions({super.key});

  @override
  State<ViewOptions> createState() => _ViewOptionsState();
}

class _ViewOptionsState extends State<ViewOptions> {

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (_, notesProvider, __) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            NoteIconButton(
                size: 18,
                icon: notesProvider.isDescending
                    ? FontAwesomeIcons.arrowDown
                    : FontAwesomeIcons.arrowUp,
                onPressed: () {
                  setState(() {
                    notesProvider.isDescending = !notesProvider.isDescending;
                  });
                }),
            SizedBox(
              width: 16,
            ),
            DropdownButton<OrderOption>(
                value: notesProvider.orderBy,
                icon: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: FaIcon(
                    FontAwesomeIcons.arrowDownWideShort,
                    size: 18,
                    color: gray700,
                  ),
                ),
                underline: SizedBox.shrink(),
                isDense: true,
                borderRadius: BorderRadius.circular(16),
                items: OrderOption.values
                    .map((e) => DropdownMenuItem(
                    value: e,
                    child: Row(
                      children: [
                        Text(e.name),
                        if (e == notesProvider.orderBy) ...[
                          SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.check)
                        ]
                      ],
                    )))
                    .toList(),
                selectedItemBuilder: (context) =>
                    OrderOption.values
                        .map((e) => Text(e.name))
                        .toList(),
                onChanged: (newValue) {
                  setState(() {
                    notesProvider.orderBy = newValue!;
                  });
                }),
            Spacer(),
            NoteIconButton(
                size: 18,
                icon: notesProvider.isGrid
                    ? FontAwesomeIcons.tableCellsLarge
                    : FontAwesomeIcons.bars,
                onPressed: () {
                  setState(() {
                    notesProvider.isGrid = !notesProvider.isGrid;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
