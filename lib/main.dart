import 'package:component_pull_away/dao/home_dao.dart';
import 'package:component_pull_away/pages/home_page.dart';
import 'package:component_pull_away/pages/second_page.dart';
import 'package:component_pull_away/pages/third_page.dart';
import 'package:f_router/navigator/f_navigator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var homeDao = HomeDao();
    homeDao.getBanner();
    // TestRouterDelegate routerDelegate = TestRouterDelegate();

    // homeDao.getaaa();
    // return MaterialApp(
    //   title: '组件抽离',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: Router(routerDelegate: routerDelegate),
    // );
    return MaterialApp.router(
        title: '组件抽离',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        //routerDelegate: routerDelegate,
        routerDelegate: FNavigator.getInstance()
            .routerDelegate(wrapPage(HomePage(title: "title"), "home")));
  }
}
