import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

class AESLogic extends EncrypterDomain {
  AESLogic._();

  static AESLogic instance = AESLogic._();

  late AesModel _aes;

  AesModel get aes => _aes;

  @override
  DartcryptModel setup({required AesModel aes}) {
    try {
      _aes = aes;
      return DartcryptModel(isSuccess: true, key: _aes.key.key, iv: _aes.iv?.iv, initializationTime: DateTime.now());
    } catch (e) {
      return DartcryptModel(isSuccess: false);
    }
  }

  @override
  String decrypt({required String cipherText}) {
    try {
      return aesLogic(mode: _aes.mode!).decrypt(model: _aes, cipherText: cipherText);
    } catch (e) {
      throw 'Decryption Failed';
    }
  }

  @override
  String encrypt({required String plainText}) {
    try {
      return aesLogic(mode: _aes.mode!).encrypt(model: _aes, plainText: plainText);
    } catch (e) {
      rethrow;
    }
  }
}
