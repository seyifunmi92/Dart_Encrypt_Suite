import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';
// ignore_for_file: avoid_print

void main() {
  final key = AESKey('my-32-byte-secret-key-0123456789');

  // 1. AES-CBC
  setup(
    mode: DartEncrypt.AES,
    model: AesModel(key: key, mode: AESModes.CBC),
  );

  final cipherText = aes.encrypt(plainText: 'Hello, world!');
  print('CBC encrypted: $cipherText');
  print('CBC decrypted: ${aes.decrypt(cipherText: cipherText)}');

  // 2. AES-CBC with HMAC (recommended): decrypt throws if the ciphertext was tampered with
  setup(
    mode: DartEncrypt.AES,
    model: AesModel(key: key, mode: AESModes.CBC, useHMAC: true, useTimeComplexity: true),
  );

  final signed = aes.encrypt(plainText: 'Transfer 100 to Alice');
  print('CBC+HMAC encrypted: $signed');
  print('CBC+HMAC decrypted: ${aes.decrypt(cipherText: signed)}');
}
