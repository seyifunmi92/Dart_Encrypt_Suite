import 'dart:convert';

class AESIV {
  final String iv;

  AESIV(this.iv) {
    final ivLength = utf8.encode(iv).length;
    if (ivLength != 16) throw ArgumentError('Initialization vector for AES must be 16 digits \n $ivLength received ');
  }
}
