import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:zass/provider/bottom_bar_provider.dart';
import 'package:zass/widgets/comments.dart';
import 'package:zass/widgets/edit.dart';
import 'null/firstpage.dart';
import 'widgets/addProduct.dart';
import 'widgets/login.dart';
import 'widgets/home.dart';
import 'widgets/bottombar.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'widgets/registerPage.dart';
import 'provider/login_provider.dart';
import 'package:provider/provider.dart';

void main() {
  //final container =ProviderC
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BottomBarProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Burdy',
        home: AnimatedSplashScreen(
            duration: 1000,
            splashIconSize: 900,
            splash: Container(
              height: 600,
              width: 350,
              child: Image.asset(
                "assets/bird-in-splash-screen.png",
              ),
            ),
            nextScreen: LogInPage(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.deepOrange.shade400),
        routes: {
          '/register': (ctx) => MyRegisterPage(),
          '/bottombar': (ctx) => BottomBar(),
          '/login': (ctx) => LogInPage(),
          // '/register': (ctx) => MyRegisterPage(),
          // '/register': (ctx) => MyRegisterPage(),
          // '/register': (ctx) => MyRegisterPage(),
          // '/register': (ctx) => MyRegisterPage(),
          // '/register': (ctx) => MyRegisterPage(),
        },
        builder: EasyLoading.init(),
      ),
    );
  }
}
