import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

abstract class DartEncryptDomain {
  void initializeEncrypter({required AesModel model, required DartEncryptSetup settings});
}
