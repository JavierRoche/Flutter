import 'package:flutter_test/flutter_test.dart';
import 'package:everPobre/domain/note.dart';

void main() {
  group("construction", () {
    test("Can create notes", () {
      expect(Note("a new note"), isNotNull);
      expect(Note.empty().body, "");
    });
  });

  // Group es para agrupar test que tengan un sentido de agrupacion
  group("dates", () {
    test("Modification is bigger than creation after modification", () {
      final note1 = Note.empty();
      note1.body = "Test";
      // La fecha de actualizacion se deberia modificar
      expect(note1.creationDate.isBefore(note1.modificationDate), isTrue);
    });
  });

  group("Object Protocol", () {
    test("equality", () {
      // Siempre que se comprueba la igualdad hay que probar tambien equivalente y falso
      final n = Note("Mi nota");
      expect(n, n);
      expect(n, Note("Mi nota"));
      expect(n != Note.empty(), isTrue);
    });

    test("hashCode", () {
      // Dos objetos que son iguales deben tener el mismo hashCode
      // Como aunque se crean seguidas hay una minima diferencia de nanosegundos
      // Por eso al reescribir el hashCode limitamos la precision a segundos
      final n1 = Note("Mi nota");
      final n2 = Note("Mi nota");
      expect(n1.hashCode, n2.hashCode);
    });
  });
}
