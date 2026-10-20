import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/domain/interfaces/aes_domain.dart';

class AESLogic extends EncrypterDomain {
  AESLogic._();

  static AESLogic? _aesLogic;

  AesModel? _aes;

  factory AESLogic() {
    _aesLogic ??= AESLogic._();
    return _aesLogic!;
  }

  @override
  Future<bool> setup({required AesModel aes}) async {
    _aes = aes;
    return true;
  }
}
