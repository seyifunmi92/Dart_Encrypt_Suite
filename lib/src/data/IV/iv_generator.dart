import 'dart:math';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';

class IvGenerator {
  static Uint8List go() {
    final secureRandom = FortunaRandom();
    final seedSource = Random.secure();
    final seed = List<int>.generate(32, (_) => seedSource.nextInt(256));
    secureRandom.seed(KeyParameter(Uint8List.fromList(seed)));
    return secureRandom.nextBytes(16);
  }
}
