import 'package:everPobre/domain/notebooks.dart';
import 'package:everPobre/scenes/notes_scene.dart';
import 'package:flutter/material.dart';

// En el momento en el que esta clase tiene que estar a la escucha de cambios
// hay que pasar el Stateless a Statefull, momento en el que se crea la una nueva clase con State
class NotebooksListView extends StatefulWidget {
  final Notebooks _model;

  // Constructor
  // Cuando devuelves un const el sistema se asegura que solo haya una instancia de la clase
  const NotebooksListView(Notebooks model) : _model = model;

  // Al pasar la clase a Statefull se crea este constructor de la clase con State
  @override
  _NotebooksListViewState createState() => _NotebooksListViewState();
}

class _NotebooksListViewState extends State<NotebooksListView> {
  // Clausura que es la que va a escuchar los cambios
  void modelDidChange() {
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // Damos de alta el widget como escuchador
    widget._model.addListener(modelDidChange);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Damos de baja el widget como escuchador
    widget._model.removeListener(modelDidChange);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
     * El constructor builder crea otro build
     * itemExtent es la cantidad de cosas que quiero meter en la lista
     * itemBuild es la funcion que crea las vistas de las cosas
     * itemCount es la altura de cada celda
     */
    return ListView.builder(
        itemCount: widget._model.length,
        itemBuilder: (context, index) {
          return NotebookSliver(widget._model, index);
        });
  }
}

// Subvistas de algo scrolleable que forma las celdas
class NotebookSliver extends StatefulWidget {
  final Notebooks notebooks;
  final int index;

  // Constructor
  const NotebookSliver(Notebooks notebooks, int index)
      : notebooks = notebooks,
        index = index;

  @override
  _NotebookSliverState createState() => _NotebookSliverState();
}

class _NotebookSliverState extends State<NotebookSliver> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      // Permite arrastras una celda
      onDismissed: (direction) {
        // Eliminamos el notebook del widget
        widget.notebooks.removeAt(widget.index);

        // Avisar al usuario de que el notebook se ha eliminado
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Element ${widget.index}"),
        ));

        setState(() {});
      },
      // Lo que se muestra mientras arrastras una celda que tiene onDismissed
      background: Container(
        color: Colors.red,
      ),
      // Tarjeta con la info de la celda
      child: Card(
          child: GestureDetector(
              onTap: () {
                print(widget.notebooks[widget.index]);
                Navigator.pushNamed(context, NotesListView.routeName,
                    arguments: widget.notebooks[widget.index]);
              },
              child: ListTile(
                leading: const Icon(Icons.list),
                title: Text(widget.notebooks[widget.index].body),
              ))),
    );
  }
}
