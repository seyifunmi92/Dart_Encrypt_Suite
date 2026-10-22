import 'dart:convert';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';
import 'package:dart_encrypt_suite/src/data/IV/iv_generator.dart';
import 'package:dart_encrypt_suite/src/data/AES/aes_base_logic.dart';

class CbcLogic extends AesBaseLogic {
  @override
  String encrypt({required AesModel model, required String plainText}) {
    try {
      return model.useHMAC == true ? encryptWithHMAC(model, plainText) : encryptNoHMAC(model, plainText);
    } catch (e) {
      throw 'Encryption Failed';
    }
  }

  String encryptNoHMAC(AesModel model, String plainText) {
    try {
      final raw = [model.key.key, plainText];
      final rawBytes = raw.map((e) => Uint8List.fromList(utf8.encode(e))).toList();
      final keyBytes = rawBytes[0];
      final plainBytes = rawBytes[1];
      final ivBytes = IvGenerator.go();
      final params = PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(keyBytes), ivBytes), null);
      final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(true, params);
      final cipherBytes = cipher.process(plainBytes);
      final ivBase64 = base64.encode(ivBytes);
      final cipherBase64 = base64.encode(cipherBytes);
      return '$ivBase64:$cipherBase64';
    } catch (e) {
      throw 'Encrypytion failed';
    }
  }

  String encryptWithHMAC(AesModel model, String plainText) {
    try {
      final raw = [model.key.key, plainText];
      final rawBytes = raw.map((e) => Uint8List.fromList(utf8.encode(e))).toList();
      final keyBytes = rawBytes[0];
      final plainBytes = rawBytes[1];
      final ivBytes = IvGenerator.go();
      final params = PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(keyBytes), ivBytes), null);
      final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(true, params);
      final cipherBytes = cipher.process(plainBytes);
      final cipherBase64 = base64.encode(cipherBytes);
      final ivBase64 = base64.encode(ivBytes);

      //generate HMAC
      final hmac = HMac(SHA256Digest(), 64)..init(KeyParameter(keyBytes));
      final hmacBytes = hmac.process(cipherBytes);
      final hmacBase64 = base64.encode(hmacBytes);
      return '$ivBase64:$cipherBase64:$hmacBase64';
    } catch (e) {
      throw 'Encryption Failed';
    }
  }
}
