# dart_encrypt_suite

A Dart/Flutter encryption package that gives you a clean, single-function API for AES encryption — without the boilerplate.

Most encryption implementations in Dart require you to wire up cipher parameters, manage IVs, handle padding, and know which PointyCastle class does what. This package handles all of that internally. You bring the key and the data.

---

## What it does

- AES-CBC encryption with optional HMAC-SHA256 integrity verification
- AES-GCM encryption with optional Additional Authenticated Data (AAD) *(coming in v1.1)*
- Cryptographically secure, randomly generated IV per encryption — embedded in the payload
- Automatic payload detection on decrypt — no flags needed
- Interoperability with server-side encrypted payloads (Node, Java, Python, etc.)
- Timing-safe HMAC comparison to prevent oracle attacks

---

## Installation

```yaml
dependencies:
  dart_encrypt_suite: ^0.0.1
```

```bash
flutter pub get
```

---

## Quick Start

```dart
import 'package:dart_encrypt_suite/dart_encrypt_suite.dart';

void main() {
  // Setup
  final result = setup(
    mode: DartEncrypt.AES,
    model: AesModel(
      key: AESKey('1234567890123456'),
      mode: AESModes.CBC,
    ),
  );

  if (!result.isSuccess) return;

  // Encrypt
  final cipherText = aes.encrypt(plainText: 'Hello World');

  // Decrypt
  final plainText = aes.decrypt(cipherText: cipherText);
}
```

---

## AES-CBC

### Basic encryption

```dart
final model = AesModel(
  key: AESKey('1234567890123456'), // 16, 24, or 32 bytes
  mode: AESModes.CBC,
);

setup(mode: DartEncrypt.AES, model: model);

final cipher = aes.encrypt(plainText: 'sensitive data');
final plain  = aes.decrypt(cipherText: cipher);
```

The IV is generated randomly on every encryption call and embedded in the payload as `ivBase64:cipherBase64`. You never manage it.

---

### With HMAC integrity check

Enabling HMAC attaches a SHA-256 signature to the ciphertext. Decryption will reject any payload that has been tampered with.

```dart
final model = AesModel(
  key: AESKey('1234567890123456'),
  mode: AESModes.CBC,
  useHMAC: true,
  useTimeComplexity: true,
);

setup(mode: DartEncrypt.AES, model: model);

final cipher = aes.encrypt(plainText: 'sensitive data');
final plain  = aes.decrypt(cipherText: cipher);
```

Payload format becomes `ivBase64:cipherBase64:hmacBase64`. The package detects this automatically on decrypt — you do not set a flag.

> `useHMAC` and `useTimeComplexity` must always be set together. One without the other will throw at model construction.

---

### Decrypting server-side ciphertext

If your backend encrypted the data with a fixed IV and returned raw base64 (no IV embedded), pass the IV through the model:

```dart
final model = AesModel(
  key: AESKey('1234567890123456'),
  mode: AESModes.CBC,
  iv: AESIV('abcdefghijklmnop'), // the IV your server used, exactly 16 bytes
);

setup(mode: DartEncrypt.AES, model: model);

final plain = aes.decrypt(cipherText: serverCipherBase64);
```

If the server did not use an IV at all, omit the `iv` field:

```dart
final model = AesModel(
  key: AESKey('1234567890123456'),
  mode: AESModes.CBC,
);
```

The package figures out which case applies from the payload structure.

---

## Key sizes

| Key length | Security level |
|------------|---------------|
| 16 bytes   | AES-128        |
| 24 bytes   | AES-192        |
| 32 bytes   | AES-256        |

Passing a key of any other length throws an `ArgumentError` at construction.

---

## Business rules

These are enforced at model construction — they throw before any encryption happens.

- `useHMAC` and `useTimeComplexity` must both be `true` or both be `false`. Mixed values are rejected.
- HMAC is only valid for CBC mode. Setting it on GCM throws.
- AAD (Additional Authenticated Data) is only valid for GCM mode. Setting it on CBC throws.
- IV, when supplied, must be exactly 16 bytes.

---

## Payload format reference

| Scenario | Payload structure |
|---|---|
| CBC, no HMAC | `ivBase64:cipherBase64` |
| CBC, with HMAC | `ivBase64:cipherBase64:hmacBase64` |
| External, IV supplied | `cipherBase64` (raw) |
| External, no IV | `cipherBase64` (raw) |

Decryption routes automatically based on segment count and model configuration.

---

## Using the lower-level API

If you need direct access to CBC or GCM logic without the singleton:

```dart
final logic = aesLogic(mode: AESModes.CBC);

final cipher = logic.encrypt(model: model, plainText: 'data');
final plain  = logic.decrypt(model: model, cipherText: cipher);
```

---

## Roadmap

- [x] AES-CBC (basic + HMAC)
- [x] Server-side interop (external IV / no IV)
- [ ] AES-GCM with AAD
- [ ] RSA encryption / decryption

---

## License

MIT