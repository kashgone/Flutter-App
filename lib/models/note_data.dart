import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/database/hive.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  //final db = HiveDatabase();
  List<Note> allNotes = [Note(id: 0, text: 'first note')];

  void initializeNotes() {
    //  allNotes = db.loadNotes();
  }

  List<Note> getAllNotes() {
    return allNotes;
  }

  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  void updateNewNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        allNotes[i].text = text;
        break; // exit loop once the note has been updated
      }
    }
    notifyListeners();
  }

  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }

  void updateNote(Note note, String text) {}
}
