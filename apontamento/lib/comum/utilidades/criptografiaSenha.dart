import 'dart:convert';

import 'package:apontamento/env.dart';
import 'package:crypto/crypto.dart';

class CriptografiaSenha {
  static String encodePassword(String senha) {
    var key = utf8.encode(CHAVE_CRIPTOGRAFIA);
    var bytes = utf8.encode(senha);
    var hmacSha256 = new Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    return digest.toString().toUpperCase();
  }

  static String decodePassword(String senha) {
    List<int> messageBytes = utf8.encode(senha);
    List<int> keyDe = base64.decode(CHAVE_CRIPTOGRAFIA);
    Hmac hmac = new Hmac(sha256, keyDe);
    Digest digest = hmac.convert(messageBytes);
    return digest.toString().toUpperCase();
  }
}
