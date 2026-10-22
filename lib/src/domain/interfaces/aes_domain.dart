import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';

abstract class EncrypterDomain {
  void setup({required AesModel aes});

  String encrypt({required String plainText});

  String decrypt();
}
