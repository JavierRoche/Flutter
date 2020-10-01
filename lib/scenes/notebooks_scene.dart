import 'package:everPobre/domain/notebooks.dart';
import 'package:everPobre/main.dart';
import 'package:flutter/material.dart';

// Una clase pasa de Stateless a Statefull cuando tiene que escuchar cambios
// Estos cambios de estado los representa una nueva clase que extiende de State
class NotebooksListView extends StatefulWidget {
  final Notebooks _notebooks;

  // Cuando devuelves un const el sistema se asegura que solo haya una instancia de la clase
  const NotebooksListView(Notebooks notebooks) : _notebooks = notebooks;

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
    widget._notebooks.addListener(modelDidChange);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Damos de baja el widget como escuchador
    widget._notebooks.removeListener(modelDidChange);

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
        itemCount: widget._notebooks.length,
        itemBuilder: (context, index) {
          return NotebooksSliver(widget._notebooks, index);
        });
  }
}

// Subvistas de algo scrolleable que forma las celdas
class NotebooksSliver extends StatefulWidget {
  final Notebooks notebooks;
  final int index;

  // Constructor
  const NotebooksSliver(Notebooks notebooks, int index)
      : notebooks = notebooks,
        index = index;

  @override
  _NotebookSliverState createState() => _NotebookSliverState();
}

// El Sliver tiene que ver realmente con la celda y su contenido
class _NotebookSliverState extends State<NotebooksSliver> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      // Permite arrastrar una celda
      onDismissed: (direction) {
        // Eliminamos el notebook del widget
        widget.notebooks.removeAt(widget.index);

        // Avisar al usuario de que el notebook se ha eliminado
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
        onTap: () {
          print(widget.notebooks[widget.index]);
          Navigator.pushNamed(context, NotesList.routeName,
              arguments: widget.notebooks[widget.index]);
        },
        leading: const Icon(Icons.list),
        title: Text(widget.notebooks[widget.index].body),
      )),
    );
  }
}
