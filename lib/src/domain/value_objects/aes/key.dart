import 'dart:convert';

class AESKey {
  final String key;

  AESKey(this.key) {
    final validKeyLengths = [16, 24, 32];
    final keyLength = utf8.encode(key).length;
    if (!validKeyLengths.contains(keyLength)) throw ArgumentError('Invalid key length of $keyLength bytes \nAES Encryption key must exactly be 16, 24, or 32 bytes');
  }
}
