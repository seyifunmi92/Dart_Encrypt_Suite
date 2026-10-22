# Changelog

All notable changes to this project will be documented in this file.

## [0.0.1] - 2026-10-22

### Added
- AES-CBC encryption with PKCS7 padding
- AES-CBC decryption with automatic payload detection
- HMAC-SHA256 integrity verification for CBC payloads
- Timing-safe HMAC comparison to prevent oracle attacks
- Cryptographically secure random IV generation per encryption using FortunaRandom
- IV embedded in payload — never managed by the caller
- Server-side interop — decrypt payloads encrypted externally with a fixed or no IV
- `AESKey` value object — enforces 16, 24, or 32 byte key lengths
- `AESIV` value object — enforces exactly 16 byte IV length
- `AesModel` domain model — all business rules validated at construction
- `AESLogic` singleton — top-level entry point for encrypt/decrypt
- `AesBaseFactory` — routes to correct cipher logic based on mode
- `SetupBase` — initialises the encrypter and returns a setup result model
- `DartcryptModel` — carries setup result, key, IV, and initialization timestamp