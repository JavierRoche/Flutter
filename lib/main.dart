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
          NotesList.routeName: (context) => NotesList()
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
  static const routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    final Notebook notebook =
        ModalRoute.of(context).settings.arguments as Notebook;

    return Scaffold(
      appBar: AppBar(
        title: Text(TextResources.detailName),
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
