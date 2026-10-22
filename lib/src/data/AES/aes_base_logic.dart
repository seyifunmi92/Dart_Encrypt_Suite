import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

abstract class AesBaseLogic {
  String encrypt({required AesModel model, required String plainText});

  String decrypt({required AesModel model, required String cipherText});
}
