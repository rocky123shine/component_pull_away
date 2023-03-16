import 'package:component_pull_away/dao/home_dao.dart';
import 'package:component_pull_away/pages/home_page.dart';
import 'package:component_pull_away/pages/second_page.dart';
import 'package:component_pull_away/router/router_info.dart';
import 'package:f_router/base/base_page.dart';
import 'package:f_router/base/base_widget.dart';
import 'package:f_router/navigator/f_navigator2.dart';
import 'package:flutter/material.dart';
import 'package:f_router/utils/log.dart';
void main() {
  //runApp(MyApp());
  Log.debug(isDebug: true);
  Log.d("hhaahahahahahah");
  runApp(RiseApp());
}

class RiseApp extends BaseStatelessWidget {
  RiseApp({super.key});

  @override
  BuildWidget get buildWidget => (context) =>
      // MaterialApp.router(
      //   title: '组件抽离111',
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //   ),
      //   //routerDelegate: routerDelegate,
      //   routerDelegate: FNavigator.instance.routerDelegate(AppRouterInfo()),
      // );
      MaterialApp(
        title: '组件抽离',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Router(
            routerDelegate:
                FNavigator.instance.routerDelegate(AppRouterInfo())),
      );
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => MyAppState();
// }
//
// class MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     var homeDao = HomeDao();
//     homeDao.getBanner();
//     // TestRouterDelegate routerDelegate = TestRouterDelegate();
//
//     // homeDao.getaaa();
//     // return MaterialApp(
//     //   title: '组件抽离',
//     //   theme: ThemeData(
//     //     primarySwatch: Colors.blue,
//     //   ),
//     //   home: Router(routerDelegate: routerDelegate),
//     // );
//     return MaterialApp.router(
//         title: '组件抽离111',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         //routerDelegate: routerDelegate,
//         routerDelegate: FNavigator.instance.routerDelegate(AppRouterInfo()));
//   }
// }
