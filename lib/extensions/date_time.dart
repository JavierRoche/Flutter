extension Equality on DateTime {
  bool almostEqual(DateTime other, {double precisionInSeconds = 1}) {
    final Duration diff = difference(other);
    // Diferencia en valor absoluto y en segundos
    final secs = diff.inSeconds.abs();
    return secs <= precisionInSeconds;
  }
}
