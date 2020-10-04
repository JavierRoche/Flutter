import 'package:everPobre/domain/note.dart';
import 'package:everPobre/domain/notebook.dart';
import 'package:everPobre/domain/notebooks.dart';
import 'package:everPobre/scenes/notes_scene.dart';
import 'package:everPobre/text_resources.dart';
import 'package:everPobre/scenes/notebooks_scene.dart';
import 'package:flutter/material.dart';

final Notebooks model = Notebooks.testDataBuilder();

void main() {
  runApp(TreeBuilder());
}

/*
 * Representa el arbol de construccion de la app
 */

class TreeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: NotebooksList.routeName,
        routes: {
          NotebooksList.routeName: (context) => NotebooksList(),
          NotesList.routeName: (context) => NotesList(),
          NoteEdition.routeName: (context) => NoteEdition()
        },
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF388E3C),
          accentColor: const Color(0xFFFFC107),
        ),
        title: TextResources.appName);
  }
}

/*
 * Representa el widget de la primera ruta: Notebooks disponibles
 */

class NotebooksList extends StatelessWidget {
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TextResources.appName),
      ),
      body: NotebooksListView(model),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.add(Notebook.testDataBuilder("Notebook nuevo"));
          },
          backgroundColor: const Color(0xFF388E3C),
          child: const Icon(Icons.add)),
    );
  }
}

/*
 * Representa el widget de la segunda ruta: Notas de un Notebook
 */

class NotesList extends StatelessWidget {
  static const routeName = "/notebookDetail";

  @override
  Widget build(BuildContext context) {
    final Notebook notebook =
        ModalRoute.of(context).settings.arguments as Notebook;

    return Scaffold(
      appBar: AppBar(
        title: Text(notebook.body),
      ),
      body: NotesListView(notebook),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            notebook.add(Note("Nota nueva"));
          },
          backgroundColor: const Color(0xFF388E3C),
          child: const Icon(Icons.add)),
    );
  }
}

/*
 * Representa una nota
 */

class NoteEdition extends StatelessWidget {
  static const routeName = "/notebookDetail/noteDetail";

  @override
  Widget build(BuildContext context) {
    // Recuperamos de los argumentos la nota de marras
    final Note note = ModalRoute.of(context).settings.arguments as Note;

    // Con el controlador le damos valor inicial al TextField
    final TextEditingController editingController =
        TextEditingController(text: note.body);
    // Si queremos controlar cada caracter introducido
    //editingController.addListener(() {});

    return Scaffold(
      appBar: AppBar(
        title: Text(note.body),
      ),
      body: Center(
        child: TextField(
          maxLength: 80,
          maxLines: 8,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(fontSize: 25),
          textInputAction: TextInputAction.done,
          autocorrect: false,
          decoration: const InputDecoration(icon: Icon(Icons.subject)),
          cursorColor: Colors.lightGreen,
          controller: editingController,
          onSubmitted: (value) {
            note.body = value;
          },
        ),
      ),
    );
  }
}
