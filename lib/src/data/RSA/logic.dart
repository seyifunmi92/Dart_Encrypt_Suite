import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/domain/interfaces/aes_domain.dart';

class RSALogic extends EncrypterDomain {
  @override
  Future<bool> setup({required AesModel aes}) {
    // TODO: implement setupRSA
    throw UnimplementedError();
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
