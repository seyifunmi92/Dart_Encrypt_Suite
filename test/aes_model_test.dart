import 'package:flutter_test/flutter_test.dart';
import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

void main() {
  final key = AESKey('1234567890123456');

  group('AesModel business rules', () {
    test('HMAC true + timeComplexity true on CBC is valid', () {
      expect(() => AesModel(key: key, mode: AESModes.CBC, useHMAC: true, useTimeComplexity: true), returnsNormally);
    });

    test('HMAC on GCM mode throws', () {
      expect(() => AesModel(key: key, mode: AESModes.GCM, useHMAC: true, useTimeComplexity: true), throwsArgumentError);
    });

    test('HMAC true + timeComplexity false throws', () {
      expect(() => AesModel(key: key, mode: AESModes.CBC, useHMAC: true, useTimeComplexity: false), throwsArgumentError);
    });

    test('HMAC false + timeComplexity true throws', () {
      expect(() => AesModel(key: key, mode: AESModes.CBC, useHMAC: false, useTimeComplexity: true), throwsArgumentError);
    });

    test('AAD on CBC mode throws', () {
      expect(() => AesModel(key: key, mode: AESModes.CBC, aad: 'some-aad'), throwsArgumentError);
    });

    test('AAD on GCM mode is valid', () {
      expect(() => AesModel(key: key, mode: AESModes.GCM, aad: 'some-aad'), returnsNormally);
    });
  });
}
