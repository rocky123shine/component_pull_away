import 'package:component_pull_away/dao/home_dao.dart';
import 'package:component_pull_away/router/router_info.dart';
import 'package:f_router/base/base_widget.dart';
import 'package:f_router/navigator/f_navigator2.dart';
import 'package:f_router/navigator/router_delegate.dart';
import 'package:flutter/material.dart';

void main() {
  // runApp(const MyApp());
  runApp(RiseApp());
}

class RiseApp extends BaseStatefulWidget {
  RiseApp({super.key});

  @override
  void initState() {
    super.initState();
    print("title33333main2 init......");
  }

  // @override
  // BuildWidget get buildWidget => (context) => MaterialApp.router(
  //       title: '组件抽离111',
  //       theme: ThemeData(
  //         primarySwatch: Colors.blue,
  //       ),
  //       //routerDelegate: routerDelegate,
  //       routerDelegate: FNavigator.instance.routerDelegate(AppRouterInfo()),
  //     );
  @override
  BuildWidget get buildWidget => (context) => MaterialApp(
        title: '组件抽离',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Router(
            routerDelegate:
                FNavigator.instance.routerDelegate(AppRouterInfo())),
      );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var homeDao = HomeDao();
    homeDao.getBanner();
    // TestRouterDelegate routerDelegate = TestRouterDelegate();

    //homeDao.getaaa();
    return MaterialApp(
      title: '组件抽离',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(
          routerDelegate: FNavigator.instance.routerDelegate(AppRouterInfo())),
    );
    // return MaterialApp.router(
    //   title: '组件抽离111',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   //routerDelegate: routerDelegate,
    //   routerDelegate: FRouterDelegate(AppRouterInfo())//FNavigator.instance.routerDelegate(AppRouterInfo()),
    // );
  }
}
