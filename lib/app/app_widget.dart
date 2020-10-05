import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: Modular.navigatorKey,
      title: 'PET +',
      theme: ThemeData(
        primaryColor: DefaultColors.primary,
        secondaryHeaderColor: DefaultColors.secondary,
        scaffoldBackgroundColor: DefaultColors.surface,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        canvasColor: Colors.white,
        accentColor: DefaultColors.secondary,
      ),
      initialRoute: '/',
      onGenerateRoute: Modular.generateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt', 'BR')],
    );
  }
}
