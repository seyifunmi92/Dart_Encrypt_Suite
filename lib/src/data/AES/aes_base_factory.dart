import 'package:dart_encrypt_suite/src/data/AES/aes_modes.dart';
import 'package:dart_encrypt_suite/src/data/AES/cbc_logic.dart';
import 'package:dart_encrypt_suite/src/data/AES/gcm_logic.dart';
import 'package:dart_encrypt_suite/src/data/AES/aes_base_logic.dart';

class AesBaseFactory {
  AesBaseFactory({required this.mode});
  AESModes mode;
  AesBaseLogic get logic => mode == AESModes.CBC ? CbcLogic() : GCMLogic();
}
