import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_data.dart';
import 'package:provider/provider.dart';
import 'package:notes_app/models/editing_note_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initializeNotes();
  }

  void createNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    Note newNote = Note(id: id, text: 'text');

    goToNotePage(newNote, true);
  }

  void goToNotePage(Note note, bool isNewNote) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditingNotePage(note: note, isNewNote: isNewNote),
      ),
    );
  }

  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          child: const Icon(Icons.add),
        ),
        //appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 25.0, top: 75),
              child: Text(
                'Notes',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            value.getAllNotes().length == 0
                ? Text('nothing here')
                : CupertinoListSection.insetGrouped(
                    children: List.generate(
                      value.getAllNotes().length,
                      (index) => CupertinoListTile(
                        title: Text(value.getAllNotes()[index].text),
                        onTap: () =>
                            goToNotePage(value.getAllNotes()[index], false),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteNote(value.getAllNotes()[index]),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
