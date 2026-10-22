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
      return model.useHMAC == true ? _encryptWithHMAC(model, plainText) : _encryptNoHMAC(model, plainText);
    } catch (e) {
      throw 'Encryption Failed';
    }
  }

  String _encryptNoHMAC(AesModel model, String plainText) {
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

  String _encryptWithHMAC(AesModel model, String plainText) {
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
      final hmacBytes = hmac.process(Uint8List.fromList([...ivBytes, ...cipherBytes]));
      final hmacBase64 = base64.encode(hmacBytes);
      return '$ivBase64:$cipherBase64:$hmacBase64';
    } catch (e) {
      throw 'Encryption Failed';
    }
  }

  @override
  String decrypt({required AesModel model, required String cipherText}) {
    try {
      final split = cipherText.split(':');
      if (model.useHMAC == true) {
        if (split.length != 3) throw 'Decryption Failed';
        return _decryptWithHMAC(model, split);
      }
      if (split.length == 2) return _decryptWithIV(model, split);
      if (split.length == 1 && model.iv != null) return _decryptExternalWithIV(model, cipherText);
      if (split.length == 1 && model.iv == null) return _decryptExternalNoIV(model, cipherText);
      throw 'Unable to decrypt at the moment';
    } catch (e) {
      throw 'Decryption Failed';
    }
  }

  String _decryptWithHMAC(AesModel model, List<String> parts) {
    try {
      final keyBytes = Uint8List.fromList(utf8.encode(model.key.key));
      final ivBytes = base64.decode(parts[0]);
      final cipherBytes = base64.decode(parts[1]);
      final receivedHmac = base64.decode(parts[2]);
      final hmac = HMac(SHA256Digest(), 64)..init(KeyParameter(keyBytes));
      final expectedHmac = hmac.process(Uint8List.fromList([...ivBytes, ...cipherBytes]));
      if (!_timingSafeEquals(receivedHmac, expectedHmac)) throw 'Decryption Failed';

      //lets decrypt
      final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(false, PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(keyBytes), ivBytes), null));
      return utf8.decode(cipher.process(cipherBytes));
    } catch (e) {
      throw 'Decryption Failed';
    }
  }

  String _decryptWithIV(AesModel model, List<String> parts) {
    try {
      final keyBytes = Uint8List.fromList(utf8.encode(model.key.key));
      final ivBytes = base64.decode(parts[0]);
      final cipherBytes = base64.decode(parts[1]);
      final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(false, PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(keyBytes), ivBytes), null));
      return utf8.decode(cipher.process(cipherBytes));
    } catch (e) {
      throw 'Decryption Failed';
    }
  }

  String _decryptExternalWithIV(AesModel model, String cipherText) {
    try {
      final keyBytes = Uint8List.fromList(utf8.encode(model.key.key));
      final ivBytes = Uint8List.fromList(utf8.encode(model.iv!.iv));
      final cipherBytes = base64.decode(cipherText);
      final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(false, PaddedBlockCipherParameters(ParametersWithIV(KeyParameter(keyBytes), ivBytes), null));
      return utf8.decode(cipher.process(cipherBytes));
    } catch (e) {
      throw 'Decryption Failed';
    }
  }

  String _decryptExternalNoIV(AesModel model, String cipherText) {
    try {
      final keyBytes = Uint8List.fromList(utf8.encode(model.key.key));
      final cipherBytes = base64.decode(cipherText);
      final cipher = PaddedBlockCipher('AES/CBC/PKCS7')..init(false, PaddedBlockCipherParameters(KeyParameter(keyBytes), null));
      return utf8.decode(cipher.process(cipherBytes));
    } catch (e) {
      throw 'Decryption Failed';
    }
  }

  bool _timingSafeEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    var res = 0;
    for (var i = 0; i < a.length; i++) {
      res |= a[i] ^ b[i];
    }
    return res == 0;
  }
}
