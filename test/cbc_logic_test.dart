import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';
import 'package:dart_encrypt_suite/src/data/AES/cbc_logic.dart';

void main() {
  final key = AESKey('1234567890123456');
  final cbc = CbcLogic();

  group('CBC without HMAC', () {
    final model = AesModel(key: key, mode: AESModes.CBC);

    test('round trips', () {
      final cipherText = cbc.encrypt(model: model, plainText: 'hello world');
      expect(cbc.decrypt(model: model, cipherText: cipherText), 'hello world');
    });

    test('uses a fresh IV per encryption', () {
      expect(cbc.encrypt(model: model, plainText: 'x'), isNot(cbc.encrypt(model: model, plainText: 'x')));
    });
  });

  group('CBC with HMAC', () {
    final model = AesModel(key: key, mode: AESModes.CBC, useHMAC: true, useTimeComplexity: true);

    test('round trips', () {
      final cipherText = cbc.encrypt(model: model, plainText: 'héllo 🔐');
      expect(cbc.decrypt(model: model, cipherText: cipherText), 'héllo 🔐');
    });

    test('rejects ciphertext with HMAC removed', () {
      final parts = cbc.encrypt(model: model, plainText: 'pay alice 100').split(':');
      expect(() => cbc.decrypt(model: model, cipherText: '${parts[0]}:${parts[1]}'), throwsA(anything));
    });

    test('rejects tampered IV', () {
      final parts = cbc.encrypt(model: model, plainText: 'pay alice 100').split(':');
      final iv = base64.decode(parts[0])..[0] ^= 1;
      expect(() => cbc.decrypt(model: model, cipherText: '${base64.encode(iv)}:${parts[1]}:${parts[2]}'), throwsA(anything));
    });

    test('rejects tampered ciphertext', () {
      final parts = cbc.encrypt(model: model, plainText: 'pay alice 100').split(':');
      final cipherBytes = base64.decode(parts[1])..[0] ^= 1;
      expect(() => cbc.decrypt(model: model, cipherText: '${parts[0]}:${base64.encode(cipherBytes)}:${parts[2]}'), throwsA(anything));
    });
  });
}
