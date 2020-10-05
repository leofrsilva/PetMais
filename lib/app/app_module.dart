import 'package:dio/dio.dart';
import 'package:petmais/app/modules/splash/splash_module.dart';
import 'package:petmais/app/shared/repository/usuario_remote/usuario_remote_repository.dart';
import 'package:petmais/app/shared/stores/auth/auth_store.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:petmais/app/app_widget.dart';

import 'modules/auth/auth_module.dart';
import 'modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => AuthStore()),
        Bind((i) => Dio(BaseOptions(baseUrl: UsuarioRemoteRepository.URL))),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: SplashModule()),
        ModularRouter("/auth", module: AuthModule(), transition: TransitionType.leftToRight),
        ModularRouter("/home", module: HomeModule(), transition: TransitionType.scale),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
