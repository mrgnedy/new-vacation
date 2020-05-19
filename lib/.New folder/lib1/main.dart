import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import 'ScopedModels/ScopedModeResultSearchPage.dart';
import 'ScopedModels/ScopedModelMainPageAdvertiser.dart';
import 'ScopedModels/ScopedModelMainPageUser.dart';
import 'ScopedModels/ScopedModelShowChalet.dart';
import 'ScopedModels/ScopedModelSkipePage.dart';
import 'ScopedModels/ScopedModelUpdateUser.dart';

import 'SplashPage.dart';

//--------- Singleton Objects-----------//
void setupLocator()
{

  GetIt.I.registerLazySingleton(() => ScopedModelUpdateUser());
  GetIt.I.registerLazySingleton(() => ScopedModelMainPageAdvertiser());
  GetIt.I.registerLazySingleton(() => ScopedModelMainPageUser());
  GetIt.I.registerLazySingleton(() => ScopedModelShowChalet());
  GetIt.I.registerLazySingleton(() => ScopedModeResultSearchPage());
  GetIt.I.registerLazySingleton(() => ScopedModelSkipePage());

}

void main()
{
   setupLocator();
  // MapView.setApiKey("AIzaSyBh38dZvcWtVR44od4QcVMS7A4GBhWhe2A");
   runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'UI Kit',
//      theme: ThemeData(
//        brightness: Brightness.light,
//        primarySwatch: Colors.amber,
//      ),
//      routes: {
//        '/': (context) => WelcomePage(),
//        '/grocerry/auth': (context) => AuthPage(),
//        '/grocerry/verify': (context) => VerifyPage(),
//        '/grocerry/home': (context) => HomePage(),
//        '/grocerry/cart': (context) => CartPage(),
//      },
//    );
//  }
//}
