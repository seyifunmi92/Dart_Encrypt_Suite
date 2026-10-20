import 'package:dart_encrypt_suite/src/data/AES/logic.dart';
import 'package:dart_encrypt_suite/src/data/RSA/logic.dart';
import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/data/setup/algorithm.dart';
import 'package:dart_encrypt_suite/src/domain/interfaces/aes_domain.dart';
import 'package:dart_encrypt_suite/src/domain/interfaces/dart_encrypt_domain.dart';

class DartEncryptSetup extends DartEncryptDomain {
  DartEncryptSetup._(this._domain);

  static DartEncryptSetup aes = DartEncryptSetup._(AESLogic.instance);

  static DartEncryptSetup rsa = DartEncryptSetup._(RSALogic());

  final EncrypterDomain _domain;

  DartEncrypt? mode;

  @override
  void initializeEncrypter({required AesModel model, required DartEncryptSetup settings}) => settings._domain.setup(aes: model);
}
