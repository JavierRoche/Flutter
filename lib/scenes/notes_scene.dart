import 'package:everPobre/domain/notebook.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// En el momento en el que esta clase tiene que estar a la escucha de cambios
// hay que pasar el Stateless a Statefull, momento en el que se crea la una nueva clase con State
class NotesListView extends StatefulWidget {
  static final routeName = "/detail";
  Notebook _model;

  // Constructor
  // Cuando devuelves un const el sistema se asegura que solo haya una instancia de la clase
  //NotesListView(Notebook model) : _model = model;
  NotesListView();

  // Al pasar la clase a Statefull se crea este constructor de la clase con State
  @override
  _NotesListViewState createState() => _NotesListViewState();

  NotesListView giveMeWidget() {
    return this;
  }
}

class _NotesListViewState extends State<NotesListView> {
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
    final Notebook nb = ModalRoute.of(context).settings.arguments as Notebook;
    widget._model = nb;
    /*
     * El constructor builder crea otro build
     * itemExtent es la cantidad de cosas que quiero meter en la lista
     * itemBuild es la funcion que crea las vistas de las cosas
     * itemCount es la altura de cada celda
     */
    return ListView.builder(
        //itemCount: widget._model.length,
        itemCount: nb.length,
        itemBuilder: (context, index) {
          //return NoteSliver(widget._model, index);
          return NoteSliver(nb, index);
        });
  }
}

// Subvistas de algo scrolleable que forma las celdas
class NoteSliver extends StatefulWidget {
  final Notebook notebook;
  final int index;

  // Constructor
  const NoteSliver(Notebook notebook, int index)
      : this.notebook = notebook,
        this.index = index;

  @override
  _NoteSliverState createState() => _NoteSliverState();
}

class _NoteSliverState extends State<NoteSliver> {
  @override
  Widget build(BuildContext context) {
    final DateFormat fmt = DateFormat("yyyy-MM-dd");

    return Dismissible(
      key: UniqueKey(),

      // Permite arrastras una celda
      onDismissed: (direction) {
        // Eliminamos la nota del widget
        widget.notebook.removeAt(widget.index);

        // Avisar al usuario de que la nota se ha eliminado
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
          child: ListTile(
              leading: Icon(Icons.toc),
              title: Text(widget.notebook[widget.index].body),
              subtitle: Text(
                  fmt.format(widget.notebook[widget.index].modificationDate)))),
    );
  }
}
