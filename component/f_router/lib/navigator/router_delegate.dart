import 'package:f_router/ext/ext.dart';
import 'package:flutter/material.dart';
import '../base/base_page.dart';
import '../listener/route_jump_listener.dart';
import '../route/route.dart';
import './f_navigator2.dart';

class RouterPath {
  final String location;

  RouterPath.home() : location = "/";
}

class FRouterDelegate extends RouterDelegate<RouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouterPath> {
  List<MaterialPage> _stackPages = [];
  RouteStatus _routeStatus = RouteStatus.home;
  Map? _args;
  final RouteInfo _routeInfo;

  FRouterDelegate(this._routeInfo)
      : navigatorKey = GlobalKey<NavigatorState>() {
    //注册监听
    FNavigator.instance.registerRouteJumpListener(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map? args}) {
      //更新target
      _routeStatus = routeStatus;
      _args = args;
      //通知 build
      notifyListeners();
    }));
  }

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    /// 处理页面
    _mangerPage();

    /// 路由实现
    /// return Navigator();
    ///解决物理返回键问题
    ///使用 WillPopScope
    return WillPopScope(
        key: GlobalKey(),

        /// 处理 android 设备 返回键
        /// 返回 true 和不实现onWillPop一样，自动返回,
        ///返回 false route不再响应物理返回事件，拦截返回事件自行处理
        onWillPop: () async =>
            !(await navigatorKey.currentState?.maybePop() ?? false),
        child: Navigator(
          key: navigatorKey,

          /// 页面栈  自己管理
          pages: _stackPages,

          ///处理导航栏上的返回按钮
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;
            //移除最后的页面
            var temList = [..._stackPages];
            _stackPages.removeLast();
            FNavigator.instance.notify(_stackPages, temList);
            return true;
          },
        ));
  }

  @override
  Future<void> setNewRoutePath(RouterPath configuration) async {}

  void _mangerPage() {
    BasePage? p = _routeInfo.getPage(_routeStatus);
    if (null == p) {
      throw Exception(
          "target page is null, please register the target(${_routeStatus.name}) page into RouteStatusInfo's child");
    }

    _routeStatus.safeCall((t) {
      //查看 target、是否在栈内
      var index = _getPageIndex(t);
      var temList = _stackPages;
      if (index != -1) {
        //此时 栈中有该页面
        //截取栈中的页面 该页面之上的页面 全部出栈
        temList = temList.sublist(0, index);
      }
      var page = p!.page!;
      //此时需要通知 具体的widge 更新状态
      _args.safeCall((t) =>
          {p = PageFactor.create(_routeStatus, page.child, args: _args)});
      //print("before _stackPages$temList");
      temList = [...temList, page];
      FNavigator.instance.notify(temList, _stackPages,);
      _stackPages = temList;
      // print("_stackPages$temList");
    });
  }

  int _getPageIndex(RouteStatus routeStatus) {
    int len = _stackPages.length;
    for (int i = 0; i < len; i++) {
      MaterialPage page = _stackPages[i];
      _routeStatus = _routeInfo.interceptRouteStatus(routeStatus);
      if (_routeStatus == getRouteStatus(page)) {
        return i;
      }
    }
    return -1;
  }

  RouteStatus getRouteStatus(MaterialPage page) {
    return _routeInfo.routeStatus(page);
  }
}
