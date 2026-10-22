import 'package:flutter_test/flutter_test.dart';
import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

void main() {
  group('AES Key Value Object', () {
    //test 1
    test('Accept only a 16 byte key', () {
      expect(() => AESKey('1234567890123456'), returnsNormally);
    });

    //test 2
    test('Accept a 24 byte key', () {
      expect(() => AESKey('123456789012345678901234'), returnsNormally);
    });

    //test 3
    test('Accept a 32 byte key', () {
      expect(() => AESKey('12345678901234567890123456789012'), returnsNormally);
    });

    //test 4
    test('Rejects a 10 byte key', () {
      expect(() => AESKey('1234567890'), throwsArgumentError);
    });

    test('Rejects a 20 byte key', () {
      expect(() => AESKey('12345678901234567890'), throwsArgumentError);
    });
  });

  //groyup 2

  group('AES IV', () {
    //test 1
    test('Accepts a 16 yte IV', () {
      expect(() => AESIV('1234567890123456'), returnsNormally);
    });

    //test 2
    test('rejects 10-byte IV', () {
      expect(() => AESIV('1234567890'), throwsArgumentError);
    });

    //test 3
    test('rejects 20-byte IV', () {
      expect(() => AESIV('12345678901234567890'), throwsArgumentError);
    });
  });
}
