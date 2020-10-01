import 'package:everPobre/extensions/date_time.dart';

class Note {
  // El body de la nota y su getter y setter
  String _body = "";
  String get body => _body;
  set body(String newValue) {
    _body = newValue;
    // Al darle un nuevo valor se considera que hay modificacion
    _modificationDate = DateTime.now();
  }

  // Las fechas de una nota y sus getter
  DateTime _creationDate;
  DateTime get creationDate => _creationDate;
  DateTime _modificationDate;
  DateTime get modificationDate => _modificationDate;

  /*
   * Constructores
   */

  Note(String contents) : _body = contents {
    _creationDate = DateTime.now();
    _modificationDate = DateTime.now();
  }
  Note.empty() : this("");

  /*
   * Object Protocol
   */

  @override
  String toString() {
    return "<$runtimeType: $body>";
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) {
      return true;
    } else {
      return other is Note &&
          other.body == body &&
          other.creationDate.almostEqual(_creationDate) &&
          other.modificationDate.almostEqual(_modificationDate);
    }
  }

  @override
  int get hashCode {
    final proxy = DateTime(
        _creationDate.year,
        _creationDate.month,
        _creationDate.day,
        _creationDate.hour,
        _creationDate.minute,
        _creationDate.second);
    return proxy.hashCode;
  }
}
