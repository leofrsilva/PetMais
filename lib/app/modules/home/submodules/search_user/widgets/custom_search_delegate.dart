import 'package:flutter/material.dart';
import 'package:petmais/app/shared/models/usuario/usuario_model.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class CustomSearchDelegate extends SearchDelegate<UsuarioModel> {
  final UsuarioModel usuario;
  CustomSearchDelegate(this.usuario) : super(
       keyboardType: TextInputType.text,
       textInputAction: TextInputAction.search,
     );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        color: Colors.black26,
        //* Apagar texto de consulta
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear, color: Colors.black26),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      color: Colors.black26,
      //* Retorna para a tela anterior e retornando null
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back, color: Colors.black26),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //* Quando aperta o botão de Pesquisa no teclado
    //close(context, null);
    //* Não pode retorna Nulo
    return FutureBuilder<List<UsuarioModel>>(
      future: query.isNotEmpty
          ? _suggestionsUser(query.toLowerCase().trim())
          : null,
      builder: (context, snapshot) {
        Widget defaultWidget = Container(
          width: double.infinity,
          height: double.infinity,
        );
        if (snapshot.connectionState == ConnectionState.waiting) {
          defaultWidget = Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(DefaultColors.primary),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              defaultWidget = Center(
                child: Text("Nenhum Usuário encontrado!"),
              );
            } else {
              defaultWidget = ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  List<UsuarioModel> users = snapshot.data;
                  UsuarioModel user = users[index];
                  String nomeSobreNome = user.usuarioInfoModel.nome.toLowerCase() +
                      " " +
                      user.usuarioInfoModel.sobreNome.toLowerCase();
                  if (nomeSobreNome ==
                      (user.usuarioInfoModel.nome + " " + user.usuarioInfoModel.sobreNome).toLowerCase()) {
                    return Container();
                  }
                  return ListTile(
                    title: Text(
                      user.usuarioInfoModel.nome + " " + user.usuarioInfoModel.sobreNome,
                      style: kLabelTitleStyle,
                    ),
                    onTap: () {
                      //close(context, json.encode(user.toMapUpdate()));
                    },
                  );
                },
              );
            }
          }
        }
        return defaultWidget;
      },
    );
  }

  Future<List<UsuarioModel>> _suggestionsUser(String q) async {
    
    if (q.isNotEmpty) {
      final usuarioRepository = UsuarioRemoteRepository();
      return await usuarioRepository.suggestionsUser(q);
    } else {
      return null;
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //* Não pode retorna Nulo
    //* Sugestões que apareceram no body da tela.
    return FutureBuilder<List<UsuarioModel>>(
      future: query.isNotEmpty
          ? _suggestionsUser(query.toLowerCase().trim())
          : null,
      builder: (context, snapshot) {
        Widget defaultWidget = Container(
          width: double.infinity,
          height: double.infinity,
        );
        if (snapshot.connectionState == ConnectionState.waiting) {
          defaultWidget = Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(DefaultColors.primary),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              defaultWidget = Center(
                child: Text("Nenhum Usuário encontrado!"),
              );
            } else {
              defaultWidget = ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  List<UsuarioModel> users = snapshot.data;
                  UsuarioModel user = users[index];
                  String nomeSobreNome = user.usuarioInfoModel.nome.toLowerCase() +
                      " " +
                      user.usuarioInfoModel.sobreNome.toLowerCase();
                  if (nomeSobreNome ==
                      (usuario.usuarioInfoModel.nome + " " + usuario.usuarioInfoModel.sobreNome).toLowerCase()) {
                    return Container();
                  }
                  List<String> comp = nomeSobreNome.split(query.toLowerCase());
                  return ListTile(
                    title: Text.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: comp[0],
                          style: kLabelTitleSmoothStyle,
                        ),
                        TextSpan(
                          text: query,
                          style: kLabelTitleStyle,
                        ),
                        TextSpan(
                            text: comp[1],
                            style: kLabelTitleSmoothStyle,
                            ),
                      ]),
                    ),
                    subtitle: Text(user.email, style: TextStyle(
                      color: DefaultColors.secondarySmooth.withOpacity(0.2),
                      fontFamily: "OpenSans",
                    )),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.call_made,
                        textDirection: TextDirection.rtl,
                      ),
                      onPressed: () {
                        query = user.usuarioInfoModel.nome + " " + user.usuarioInfoModel.sobreNome;
                      },
                    ),
                    onTap: () {
                      query = "";
                      close(context, user);
                    },
                  );
                },
              );
            }
          }
        }
        return defaultWidget;
      },
    );
  }
}