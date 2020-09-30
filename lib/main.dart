import 'package:everPobre/scenes/notes_scene.dart';
import 'package:everPobre/domain/notebook.dart';
import 'package:everPobre/domain/notebooks.dart';
import 'package:everPobre/text_resources.dart';
import 'package:everPobre/scenes/notebooks_scene.dart';
import 'package:flutter/material.dart';

final Notebooks model = Notebooks.testDataBuilder();

void main() {
  runApp(TreeBuilder());
}

class TreeBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: NotebooksList.routeName,
        routes: {
          NotebooksList.routeName: (context) => NotebooksList(),
          NotesListView.routeName: (context) => NotesListView()
        },
        theme: ThemeData.light().copyWith(
          primaryColor: const Color(0xFF388E3C),
          accentColor: const Color(0xFFFFC107),
        ),
        title: TextResources.appName);
  }
}

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
