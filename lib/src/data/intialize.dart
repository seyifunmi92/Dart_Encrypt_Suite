import 'package:dart_encrypt_suite/src/data/setup/algorithm.dart';

abstract class DartEncryptBase {
  Future<bool> initializePlugin({required DartEncrypt algorithm});
}
