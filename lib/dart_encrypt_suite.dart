import 'package:dart_encrypt_suite/src/data/AES/logic.dart';
import 'package:dart_encrypt_suite/src/data/AES/aes_model.dart';
import 'package:dart_encrypt_suite/src/data/setup/algorithm.dart';
import 'package:dart_encrypt_suite/src/data/setup/setup_base.dart';
library;


export 'src/data/AES/aes_model.dart';
export 'src/data/AES/aes_modes.dart';
export 'src/data/AES/logic.dart';
export 'src/data/RSA/logic.dart';
export 'src/data/setup/algorithm.dart';
export 'src/data/setup/algorithm_model.dart';
export 'src/data/setup/intialize.dart';
export 'src/domain/interfaces/aes_domain.dart';
export 'src/domain/interfaces/auth_domain.dart';
export 'src/domain/interfaces/dart_encrypt_domain.dart';
export 'src/domain/interfaces/rsa_domain.dart';
export 'src/domain/value_objects/aes/iv.dart';
export 'src/domain/value_objects/aes/key.dart';

AESLogic aes = AESLogic.instance;
void  setup({required DartEncrypt mode, required AesModel model}) => SetupBase(mode: mode).initialize(model: model);
