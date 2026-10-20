import 'package:dart_encrypt_suite/src/data/AES/aes_modes.dart';

class AesModel {
  String encryptionKey;
  String? initializationVector;
  AESModes modes;
  bool useHmac;
  bool useTimeConstraint;

  AesModel({required this.encryptionKey, this.initializationVector, required this.modes, this.useHmac = false, this.useTimeConstraint = false});
}
