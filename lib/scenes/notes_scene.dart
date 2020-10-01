import 'package:everPobre/domain/notebook.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Una clase pasa de Stateless a Statefull cuando tiene que escuchar cambios
// Estos cambios de estado los representa una nueva clase que extiende de State
class NotesListView extends StatefulWidget {
  final Notebook _model;

  // Cuando devuelves un const el sistema se asegura que solo haya una instancia de la clase
  const NotesListView(Notebook model) : _model = model;

  // Al pasar la clase a Statefull se crea este constructor de la clase con State
  @override
  _NotesListViewState createState() => _NotesListViewState();
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
    /*
     * El constructor builder crea otro build
     * itemExtent es la cantidad de cosas que quiero meter en la lista
     * itemBuild es la funcion que crea las vistas de las cosas
     * itemCount es la altura de cada celda
     */
    return ListView.builder(
        itemCount: widget._model.length,
        itemBuilder: (context, index) {
          return NoteSliver(widget._model, index);
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

// El Sliver tiene que ver realmente con la celda y su contenido
class _NoteSliverState extends State<NoteSliver> {
  @override
  Widget build(BuildContext context) {
    final DateFormat fmt = DateFormat("yyyy-MM-dd");

    return Dismissible(
      key: UniqueKey(),
      // Permite arrastrar una celda
      onDismissed: (direction) {
        // Eliminamos la nota del widget
        widget.notebook.removeAt(widget.index);

        // Avisar al usuario de que la nota se ha eliminado
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Element ${widget.index}"),
        ));

        // Avisar al modelo de que el notebook se ha eliminado
        setState(() {});
      },
      // Lo que se muestra mientras arrastras una celda que tiene onDismissed
      background: Container(
        color: Colors.red,
      ),
      // Tarjeta con la info de la celda
      child: Card(
          child: ListTile(
              leading: const Icon(Icons.toc),
              title: Text(widget.notebook[widget.index].body),
              subtitle: Text(
                  fmt.format(widget.notebook[widget.index].modificationDate)))),
    );
  }
}
