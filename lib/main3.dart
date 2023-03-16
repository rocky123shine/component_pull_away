import 'package:component_pull_away/pages/demo_home_page.dart';
import 'package:component_pull_away/pages/demo_target2_page.dart';
import 'package:component_pull_away/pages/demo_target_page.dart';
import 'package:component_pull_away/router/router_info.dart';
import 'package:f_router/navigator/f_navigator2.dart';
import 'package:f_router/navigator/router_delegate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // BiliRouteDelegate _routeDelegate = BiliRouteDelegate();
  RouterDelegate _routeDelegate = FRouterDelegate(AppRouterInfo());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: Router(
      //   routerDelegate: _routeDelegate,
      // ),
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 3)),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //预加载没有结束，展示loding
          //结束之后切换路由界面进行展示
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: FNavigator.instance.routerDelegate(AppRouterInfo()))
              : Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );

          return MaterialApp(
            home: widget,
            theme: ThemeData(primaryColor: Colors.white),
          );
        },
      ),
    );
  }
}

MaterialPage pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}


class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";

  BiliRoutePath.detail() : location = "/detail";
}
