import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

class SetupBase {
  SetupBase({required this.mode});
  DartEncrypt mode;
  DartEncryptSetup get settings => mode == DartEncrypt.AES ? DartEncryptSetup.aes : DartEncryptSetup.rsa;

  DartcryptModel initialize({required AesModel model}) => settings.initializeEncrypter(model: model, settings: settings);
}
