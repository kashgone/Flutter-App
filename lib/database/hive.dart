import 'package:hive/hive.dart';
import 'package:notes_app/models/note.dart';

class HiveDataBase {
  final _myBox = Hive.box('note_database');

  List<Note> loadNotes() {
    List<Note> savedNotesFormatted = [];
    if (_myBox.get('ALL_NOTES') != null) {
      List<dynamic> savedNotes = _myBox.get('ALL_NOTES');
      for (int i = 0; i < savedNotes.length; i++) {
        Note individualNote =
            Note(id: int.parse(savedNotes[i][0]), text: savedNotes[i][1]);

        savedNotesFormatted.add(individualNote);
      }
    }
    return savedNotesFormatted;
  }

  void saveNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      for (var note in allNotes) [note.id, note.text]
    ];
    _myBox.put('ALL_NOTES', allNotesFormatted);
  }
}
