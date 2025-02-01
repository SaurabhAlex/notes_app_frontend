import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/provider/notes_provider.dart';
import 'package:notes_app/screen/add_new_note.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes App"),
        centerTitle: true,
      ),
      body: notesProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: (notesProvider.notes.isNotEmpty)
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemCount: notesProvider.notes.length,
                      itemBuilder: (context, index) {
                        Note currentNote = notesProvider.notes[index];
                        return GestureDetector(
                          onTap: () {
                            // update
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddNewNote(
                                          isUpdate: true,
                                          note: currentNote,
                                        )));
                          },
                          onLongPress: () {
                            // delete
                            notesProvider.deleteNote(currentNote);
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border:
                                    Border.all(color: Colors.grey, width: 1)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentNote.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  currentNote.content!,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.grey[700]),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Text("No Notes yet"),
                    )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => AddNewNote(
                        isUpdate: false,
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
