import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';

abstract class EncrypterDomain {
  Future<bool> setup({required AesModel aes});
}
