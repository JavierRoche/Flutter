import 'package:flutter_test/flutter_test.dart';
import 'package:everPobre/extensions/date_time.dart';

void main() {
  test("almost equal", () {
    final d1 = DateTime.now();
    final d2 = DateTime.now();
    final d3 = DateTime.utc(1998, 11, 12);

    expect(d1.almostEqual(d2), isTrue);
    expect(d2.almostEqual(d1), isTrue);
    expect(d3.almostEqual(d2), isFalse);
  });
}
