import 'package:flutter/cupertino.dart';
import 'package:notes_app/services/api_services.dart';

import '../models/note.dart';

class NotesProvider with ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  NotesProvider() {
    fetchNotes();
  }

  void sortNotes() {
    notes.sort((a, b) => b.dateAdded!.compareTo(a.dateAdded!));
  }


  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    APIServices.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    APIServices.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    APIServices.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await APIServices.fetchNote('SaurabhAlex');
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
