import 'dart:convert';

import 'package:agronomico/env.dart';
import 'package:crypto/crypto.dart';

class CriptografiaSenha {
  static String encode(String senha) {
    var key = utf8.encode(kChaveCriptografada);
    var bytes = utf8.encode(senha);
    var hmacSha256 = new Hmac(sha256, key);
    var digest = hmacSha256.convert(bytes);
    return digest.toString().toUpperCase();
  }
}
