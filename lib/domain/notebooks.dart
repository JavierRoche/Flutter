import 'package:everPobre/domain/notebook.dart';
import 'package:flutter/material.dart';

class Notebooks with ChangeNotifier {
  // Singleton de acceso a la clase
  static final shared = Notebooks();
  // Lista donde guardaremos los Notebook
  final List<Notebook> _notebooks = [];
  // Entero que representa el tamaño de la lista
  int get length => _notebooks.length;

  // Constructores
  Notebooks();
  // Este constructor sirve para obtener una libreta llena de datos de prueba
  Notebooks.testDataBuilder() {
    // Genera una lista de Notebooks
    _notebooks.addAll(List.generate(
        10, (index) => Notebook.testDataBuilder("Notebook $index")));
  }

  // Accesores
  // Sobrecargamos el metodo [] que devuelve un Notebook de un indice
  Notebook operator [](int index) {
    return _notebooks[index];
  }

  // Metodo para añadir Notebook
  void add(Notebook notebook) {
    _notebooks.insert(0, notebook);
    // Avisamos de que se ha añadido un Notebook
    notifyListeners();
  }

  // Metodo para eliminar Notebook
  bool remove(Notebook notebook) {
    final bool isDeleted = _notebooks.remove(notebook);
    // Avisamos de que se ha eliminado un Notebook
    notifyListeners();
    return isDeleted;
  }

  Notebook removeAt(int index) {
    final Notebook nb = _notebooks.removeAt(index);
    // Avisamos de que se ha eliminado un Notebook
    notifyListeners();
    return nb;
  }

  // Object Protocol
  @override
  String toString() {
    return "<$runtimeType: $length notebook>";
  }
}
