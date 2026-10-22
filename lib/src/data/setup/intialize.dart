import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

class DartEncryptSetup extends DartEncryptDomain {
  DartEncryptSetup._(this._domain);

  static DartEncryptSetup aes = DartEncryptSetup._(AESLogic.instance);

  static DartEncryptSetup rsa = DartEncryptSetup._(RSALogic());

  final EncrypterDomain _domain;

  DartEncrypt? mode;

  @override
  DartcryptModel initializeEncrypter({required AesModel model, required DartEncryptSetup settings}) => settings._domain.setup(aes: model);
}
