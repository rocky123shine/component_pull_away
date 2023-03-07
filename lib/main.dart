import 'package:component_pull_away/dao/home_dao.dart';
import 'package:component_pull_away/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var homeDao = HomeDao();
    homeDao.getBanner();
    TestRouterDelegate routerDelegate = TestRouterDelegate();

    // homeDao.getaaa();
    return MaterialApp(
      title: '组件抽离',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(routerDelegate: routerDelegate),
    );
  }
}

MaterialPage wrapPage(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

class TestRouterDelegate extends RouterDelegate<RouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterPath> {
  RouterPath? path;

  List<MaterialPage> pages = [
    wrapPage(const HomePage(
      title: 'home',
    ))
  ];

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => GlobalKey();

  @override
  Future<void> setNewRoutePath(RouterPath configuration) async {
    path = configuration;
  }
}

class RouterPath {
  final String location;

  RouterPath.home() : location = "/";
}
