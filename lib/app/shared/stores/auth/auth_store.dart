import 'package:mobx/mobx.dart';
import 'package:petmais/app/shared/models/usuario/usuario_chat_model.dart';
import '../../models/usuario/usuario_model.dart';
import '../../models/crypto/crypto_aes.dart';
part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  //
  @observable
  UsuarioModel usuario;

  @action
  setUser(UsuarioModel value) => this.usuario = value;

  //
  @observable
  UsuarioChatModel usuarioChat;

  @action
  setUserChat(UsuarioChatModel value) => this.usuarioChat = value;

  @observable
  CryptoAes cryptoAes = CryptoAes();

  @action
  setCryptoAes(CryptoAes value) => this.cryptoAes = value;

  @computed
  bool get isLogged {
    if(this.usuario == null){
      return false;
    } else {
      return this.usuario.email != null && this.usuario.senha != null;
    }
  }
}