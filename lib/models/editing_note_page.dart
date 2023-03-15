import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes_app/models/note.dart';
import 'package:provider/provider.dart';
import 'note_data.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;

  EditingNotePage({Key? key, required this.note, required this.isNewNote})
      : super(key: key);

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();

  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  void addNewNote() {
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  void updateNote() {
    String text = _controller.document.toPlainText();
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            } else {
              updateNote();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          QuillToolbar.basic(
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
