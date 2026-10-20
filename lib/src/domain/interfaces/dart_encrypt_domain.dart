import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/data/setup/algorithm.dart';

abstract class DartEncryptDomain {
  void initializeEncrypter({required DartEncrypt mode, required AesModel model});
}
