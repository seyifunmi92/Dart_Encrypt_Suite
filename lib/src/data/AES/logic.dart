import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

class AESLogic extends EncrypterDomain {
  AESLogic._();

  static AESLogic instance = AESLogic._();

  late AesModel _aes;

  AesModel get aes => _aes;

  @override
  void setup({required AesModel aes}) async {
    _aes = aes;
  }

  @override
  String decrypt() {
    // TODO: implement decrypt
    throw UnimplementedError();
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
