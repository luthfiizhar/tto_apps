import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tto_apps/constant/color.dart';
import 'package:tto_apps/constant/constant.dart';
import 'package:tto_apps/main_model.dart';
import 'package:tto_apps/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        // child: MaterialApp.router(
        //   routeInformationProvider: router.routeInformationProvider,
        //   routeInformationParser: router.routeInformationParser,
        //   routerDelegate: router.routerDelegate,
        //   builder: (context, child) {
        //     return Overlay(
        //       initialEntries: [
        //         OverlayEntry(
        //           builder: (context) {
        //             return ResponsiveWrapper.builder(
        //               child,
        //               // minWidth: 800,
        //               maxWidth: 800,
        //               defaultScale: true,
        //               breakpoints: const [
        //                 // ResponsiveBreakpoint.resize(360, name: MOBILE),
        //                 // ResponsiveBreakpoint.resize(480, name: MOBILE),
        //               ],
        //             );
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // ),
        child: MaterialApp(
          title: 'SIKO',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              backgroundColor: eerieBlack,
            ),
          ),
          navigatorKey: navKey,
          // home: HomePage(),
          builder: (context, child) {
            return ResponsiveWrapper.builder(
              child,
              // minWidth: 800,
              maxWidth: 800,
              defaultScale: true,
              breakpoints: const [
                // ResponsiveBreakpoint.resize(360, name: MOBILE),
                // ResponsiveBreakpoint.resize(480, name: MOBILE),
              ],
            );
          },
          home: HomePage(),
          // initialRoute: '/home',
          // routes: {
          //   '/home': (context) => HomePage(),
          // },
        ),
      ),
    );
  }
}
