import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';

abstract class AesDomain {
  Future<bool> setupAES({required AesModel aes});
}
