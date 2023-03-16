import 'package:flutter/material.dart';

/// name 是page 的唯一标识  可以用常量表示 arguments 传参
MaterialPage wrapPage(Widget child, String name) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child, name: name);
}

/// FNavigator全局单例
/// 功能一 跳转
class FNavigator extends _JumToListener {
  FNavigator._();

  RouteJumpListener? _routeJumpListener;

  static FNavigator? _instance;

  static FNavigator getInstance() {
    _instance ??= FNavigator._();
    return _instance!;
  }

  ///注册路由跳转逻辑
  /// 提供注册方法  谁注册 谁监听
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJumpListener = routeJumpListener;
  }

  @override
  void onJumTo(Page target) {
    //在这里实现跳转
    //调用该方法之后 要回调通知 Router 刷新路由栈
    _routeJumpListener?.onJumpTo(target);
  }

  RouterDelegate<RouterPath> routerDelegate(Page homePage) {
    return FRouterDelegate(homePage);
  }
}

abstract class _JumToListener {
  // 参数：
  // 1 target 、
  void onJumTo(Page target);
}

typedef OnJumpTo = void Function(Page target);

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}

/// ------------
class FRouterDelegate extends RouterDelegate<RouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterPath> {
  RouterPath? path;
  List<Page> _stackPages = [];

  Page? _target;
  Page homePage;

  FRouterDelegate(this.homePage) {
    _stackPages.add(homePage);
    FNavigator.getInstance()
        .registerRouteJump(RouteJumpListener(onJumpTo: (Page target) {
      //target 要显示的目标
      _target = target;
      notifyListeners();
    }));
  }

  @override
  Widget build(BuildContext context) {
    //当 notifyListeners执行的时候  pages 会和原来的对比
    // 不一样会执行 build  新建 Navigator 显示栈顶的page
    mannerPagesStack();
    return Navigator(
      key: navigatorKey,
      pages: _stackPages,
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

  void mannerPagesStack() {
    if (_target == null) {
      return;
    }
    //查看当前页面是否在栈中 不在直接加入栈中 否则 移除所有该页面之上的page
    int index = getPageIndex(_stackPages, _target!);
    //截取栈区
    List<Page> tempPages = _stackPages;
    if (index != -1) {
      tempPages = tempPages.sublist(0, index);
    }
    tempPages = [...tempPages, _target!];
    _stackPages = tempPages;
  }

  int getPageIndex(List<Page<dynamic>> stackPages, Page target) {
    var len = stackPages.length;
    for (int i = 0; i < len; i++) {
      if (stackPages[i].name == target.name) {
        return i;
      }
    }

    return -1;
  }
}

class RouterPath {
  final String location;

  RouterPath.home() : location = "/";
}
