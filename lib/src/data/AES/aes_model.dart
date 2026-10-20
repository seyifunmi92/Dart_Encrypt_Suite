import 'package:equatable/equatable.dart';
import 'package:dart_encrypt_suite/src/data/AES/aes_modes.dart';
import 'package:dart_encrypt_suite/src/domain/value_objects/aes/iv.dart';
import 'package:dart_encrypt_suite/src/domain/value_objects/aes/key.dart';

class AesModel extends Equatable {
  final AESKey key;
  final AESIV? iv;
  final AESModes? mode;
  final bool? useHMAC;
  final bool? useTimeComplexity;

  AesModel({required this.key, this.iv, this.mode, this.useHMAC, this.useTimeComplexity}) {
    //now lets set all the business rules needed here
    if ((useHMAC == true || useTimeComplexity == true) && mode != AESModes.CBC) throw ArgumentError('Invalid selection, HMAC can only be selected for CBC mode');

    //
  }

  @override
  List<Object?> get props => [key, iv];
}
