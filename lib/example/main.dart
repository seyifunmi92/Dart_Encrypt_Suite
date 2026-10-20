import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

void main() {
  setup(
    mode: DartEncrypt.AES,
    model: AesModel(key: AESKey('key')),
  );

  //now lets encrypt
  aes.encrypt(plainText: "plainText");
  aes.decrypt();
}
