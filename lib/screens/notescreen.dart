// NoteScreen is the main screen of the app. It displays the list of notes and allows the user to add, edit, and delete notes.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<String> notes = [
    'Note 1: This is the first note',
    'Note 2: This is the second note',
    'Note 3: This is the third note',

  ];

  void _addNote() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteEditorScreen(),
      ),
    ).then((newNote) {
      if (newNote != null) {
        setState(() {
          notes.add(newNote);
        });
      }
    });
  }

  void _editNote(int index) {
    TextEditingController titleController = TextEditingController(text: notes[index].split(':')[0]);
    TextEditingController bodyController = TextEditingController(text: notes[index].split(':')[1]);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(titleController: titleController, bodyController: bodyController),
      ),
    ).then((editedNote) {
      if (editedNote != null) {
        setState(() {
          notes[index] = editedNote;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
        elevation: 0,
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              return ListTile(
                title: Card(
                  elevation: 3.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            note.split(':')[0],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _editNote(index);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              notes.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNote();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteEditorScreen extends StatelessWidget {
  final TextEditingController? titleController;
  final TextEditingController? bodyController;

  const NoteEditorScreen({Key? key, this.titleController, this.bodyController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Editor'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.deepPurple[400],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
              ),
              keyboardType: TextInputType.text,
              style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: bodyController,
                decoration: const InputDecoration(
                  hintText: 'Write your note...',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop('${titleController?.text ?? ''}: ${bodyController?.text ?? ''}');
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
