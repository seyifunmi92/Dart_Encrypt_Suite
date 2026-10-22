import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

abstract class EncrypterDomain {
  DartcryptModel setup({required AesModel aes});

  String encrypt({required String plainText});

  String decrypt({required String cipherText});
}
