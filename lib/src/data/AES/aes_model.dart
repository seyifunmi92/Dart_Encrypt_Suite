import 'package:dart_encrypt_suite/src/data/AES/aes_modes.dart';
import 'package:dart_encrypt_suite/src/domain/value_objects/aes/iv.dart';
import 'package:dart_encrypt_suite/src/domain/value_objects/aes/key.dart';

class AesModel {
  final AESKey key;
  final AESIV? iv;
  final AESModes? mode;
  final bool? useHMAC;
  final bool? useTimeComplexity;
  final String? aad;

  AesModel({required this.key, this.mode, this.iv, this.useHMAC, this.useTimeComplexity, this.aad}) {
    if ((useHMAC == true || useTimeComplexity == true) && mode != AESModes.CBC) {
      throw ArgumentError('HMAC and Time complexity checks are only valid for CBC Modes');
    }

    if (useHMAC == true && useTimeComplexity == false) {
      throw ArgumentError('Invalid selection, HMAC and Time complexity must be must together');
    }

    if (useHMAC == false && useTimeComplexity == true) {
      throw ArgumentError('Invalid selection, HMAC and Time complexity must be must together');
    }

    if (aad != null && mode != AESModes.GCM) {
      throw ArgumentError('Additional Authenticated Data is only supported in GCM Mode');
    }
  }
}
