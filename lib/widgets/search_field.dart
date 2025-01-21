import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutsi/change_notifiers/notes_provider.dart';

import '../core/constants.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final NotesProvider notesProvider;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    notesProvider = context.read<NotesProvider>();
    searchController = TextEditingController(text: notesProvider.searchTerm)
      ..addListener(() {
        notesProvider.searchTerm = searchController.text;
      });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search notes ...",
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(
          FontAwesomeIcons.magnifyingGlass,
          size: 16,
        ),
        suffixIcon: ListenableBuilder(
            listenable: searchController,
            builder: (context, clearButton) =>
                searchController.text.isNotEmpty ? clearButton! : SizedBox.shrink(),
            child: GestureDetector(
              onTap: () {
                searchController.clear();
              },
              child: Icon(
                FontAwesomeIcons.circleXmark,
              ),
            )),
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: BoxConstraints(
          minWidth: 42,
          minHeight: 42,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: 42,
          minHeight: 42,
        ),
        fillColor: white,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primary)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primary)),
      ),
    );
  }
}
