import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/domain/interfaces/aes_domain.dart';

class AESLogic extends EncrypterDomain {
  AESLogic._();

  static AESLogic instance = AESLogic._();

  AesModel? _aes;

  AesModel? get aes => _aes;

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
    // TODO: implement encrypt
    throw UnimplementedError();
  }
}
