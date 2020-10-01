import 'package:everPobre/domain/note.dart';
import 'package:flutter/material.dart';

// Para que el modelo avise de sus cambios se incluye "with ChangeNotifier"
class Notebook with ChangeNotifier {
  // El body de la nota y su getter y setter
  String _body = "";
  String get body => _body;
  set body(String newValue) {
    _body = newValue;
  }

  // Singleton de acceso a la clase
  static final shared = Notebook();
  // Lista donde guardaremos las notas
  final List<Note> _notes = [];
  // Entero que representa el tamaño de la lista
  int get length => _notes.length;

  /*
   * Constructores
   */

  Notebook();
  // Este constructor sirve para obtener una libreta llena de datos de prueba
  Notebook.testDataBuilder(String name) {
    // Genera una lista de notas
    _body = name;
    _notes.addAll(List.generate(100, (index) => Note("Item $index")));
  }

  /*
   * Accesores
   */

  // Sobrecargamos el metodo [] que devuelve una nota de un indice
  Note operator [](int index) {
    return _notes[index];
  }

  /*
   * Mutadores
   */

  // Metodo para añadir notas
  void add(Note note) {
    _notes.insert(0, note);
    // Avisamos de que se ha añadido una nota
    notifyListeners();
  }

  // Metodo para eliminar notas
  bool remove(Note note) {
    final bool isDeleted = _notes.remove(note);
    // Avisamos de que se ha eliminado una nota
    notifyListeners();
    return isDeleted;
  }

  Note removeAt(int index) {
    final Note n = _notes.removeAt(index);
    // Avisamos de que se ha eliminado una nota
    notifyListeners();
    return n;
  }

  /*
   * Object Protocol
   */

  @override
  String toString() {
    return "<$runtimeType: $length notes>";
  }
}
