import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../provider/notes_provider.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNote({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {

  FocusNode focusNode = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    if(widget.isUpdate){
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
    super.initState();
  }


  void updateNote(){
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  void addNewNote(){
    Note newNote = Note(
      id:  const Uuid().v1(),
      userId: 'SaurabhAlex',
      title: titleController.text,
      content: contentController.text,
      dateAdded: DateTime.now()
    );

    Provider.of<NotesProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {
              if(widget.isUpdate){
               updateNote();

              }else{
                addNewNote();
              }
            }, icon: Icon(Icons.check))
          ],
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  autofocus: (widget.isUpdate) ? false: true,
                  onSubmitted: (val) {
                    if(val != ''){
                      focusNode.requestFocus();
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      border: InputBorder.none),
                ),
                Expanded(
                  child: TextField(
                    controller: contentController,
                    focusNode: focusNode,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            )));
  }
}
