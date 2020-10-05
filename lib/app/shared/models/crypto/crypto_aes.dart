import 'package:encrypt/encrypt.dart';

class CryptoAes {
  static final CryptoAes _userHelper = CryptoAes._internal();

  factory CryptoAes() {
    return _userHelper;
  }

  CryptoAes._internal();

  IV _iv;
  Key _key;
  Encrypter _encrypter;
  Encrypted _encrypted;

  String get getEncrypted => this._encrypted.base64;

  void setkey(String value) {
    this._key = Key.fromUtf8(value);
    this._encrypter = Encrypter(AES(this._key));
    this._iv = IV.fromLength(16);
  }

  void setEncrypted(String value){
    this._encrypted = Encrypted.fromBase64(value);
  }

  String encryptPass(String pass) {
    Encrypted result = this._encrypter.encrypt(pass, iv: this._iv);
    this._encrypted = result;
    return result.base64;
  }

  String decryptPass() {
    if (this._encrypted != null) {      
      String pass = this._encrypter.decrypt(this._encrypted, iv: this._iv);
      return pass;
    } else {
      return null;
    }
  }
}
