import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'search_user_controller.dart';

class SearchUserPage extends StatefulWidget {
  final String title;
  const SearchUserPage({Key key, this.title = "SearchUser"}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState
    extends ModularState<SearchUserPage, SearchUserController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    controller.setContext(context);
    Future.delayed(
      Duration(milliseconds: 250),
      () => controller.showSearchUser(),
    );
    return Scaffold(
      body: Container(
        color: Colors.white70,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
