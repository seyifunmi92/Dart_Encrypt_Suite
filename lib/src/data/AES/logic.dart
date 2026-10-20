import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/domain/interfaces/aes_domain.dart';

class AESLogic extends AesDomain {
  AESLogic._();

  static AESLogic? _aesLogic;

  AesModel? _aes;

  factory AESLogic() {
    _aesLogic ??= AESLogic._();
    return _aesLogic!;
  }

  @override
  Future<bool> setupAES({required AesModel aes}) async {
    try {
      _aes = aes;
      return true;
    } catch (e) {
      return false;
    }
  }
}
