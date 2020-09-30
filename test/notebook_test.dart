import 'package:everPobre/domain/note.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:everPobre/domain/notebook.dart';

void main() {
  group("construction", () {
    test("can access the shared single notebook singleton", () {
      expect(Notebook.shared, isNotNull);
    });
  });

  group("removal", () {
    test("remove by index", () {
      // Comprobamos que devuelve la borrada
      // Con returnNormaly no se espera excepcion. No queremos comprobar que genere un error
      final Note n = Note("Hola");
      Notebook.shared.add(n);
      // Hay que poner como una clausura para que la excepcion no se evalue en el propio expect
      expect(() => Notebook.shared.removeAt(0), returnsNormally);

      // Comprobamos tambien que la nota eliminada es la añadida
      Notebook.shared.add(n);
      expect(Notebook.shared.removeAt(0), n);
    });
  });

  group("content", () {
    test("length", () {
      final nb1 = Notebook();
      final nb2 = Notebook();
      final n1 = Note("Lore Ipsum");

      expect(nb1.length, 0);
      nb2.add(n1);
      expect(nb2.length, 1);
      nb2.remove(n1);
      expect(nb2.length, 0);
    });
  });
}
