import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/modules/home/submodules/drawer/drawer_menu_module.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> with WidgetsBindingObserver{
  //use 'controller' variable to access controller

  Future _updateStatusUser(String sign) async {
    if(sign == "on"){
      await controller.setOnline();
    }
    else if(sign == "off"){
      await controller.setOffline();
    }    
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
       _updateStatusUser("on");
    }else if(state == AppLifecycleState.inactive){
      _updateStatusUser("off");
    }else if(state == AppLifecycleState.paused){
      _updateStatusUser("off");
    }
  }

  @override
  void initState() {
    super.initState();
    controller.signIn();    
    WidgetsBinding.instance.addObserver(this); 
  }

  @override
  void dispose() async {
    super.dispose();
    await _updateStatusUser("off");
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void deactivate() async {
    super.deactivate();
    await _updateStatusUser("off");
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          RouterOutlet(
            module: DrawerMenuModule(),
          ),
          Observer(
            builder: (context) {
              // Widget defaultWidget;
              // int screen = controller.screen;
              // if (screen == 0) {
              //   defaultWidget = RouterOutlet(
              //     module: AdocaoModule(),
              //   );
              // } else if (screen == 1) {
              //   defaultWidget = RouterOutlet(
              //     module: PerfilModule(),
              //     key: ValueKey("main"),
              //   );
              // }
              // Modular.outletNavigatorKey("main");
              // // else if(screen == 3){
              // //   defaultWidget = MainScreen(tabInit: 1);
              // // } else if (screen == 1) {
              // //   defaultWidget = Perfil();
              // // } else if (screen == 2) {
              // //   defaultWidget = MeusPets();
              // // }
              return AnimatedContainer(
                transform: Matrix4.translationValues(
                    controller.animationDrawer.xOffset,
                    controller.animationDrawer.yOffset,
                    0)
                  ..scale(controller.animationDrawer.scaleFactor)
                  ..rotateY(
                      controller.animationDrawer.isShowDrawer ? -0.5 : 0.0),
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    if (controller.animationDrawer.isShowDrawer) {
                      controller.animationDrawer.closeDrawer();
                    }
                  },
                  child: PageView.custom(                    
                    physics: NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                     childrenDelegate: SliverChildListDelegate(
                       controller.modulesScreen,
                       addAutomaticKeepAlives: false,
                       addRepaintBoundaries: false,
                       addSemanticIndexes: false,                       
                     ),
                     
                    // children: controller.modulesScreen,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
