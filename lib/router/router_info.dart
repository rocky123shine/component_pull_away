import 'package:f_router/base/base_page.dart';
import 'package:f_router/ext/ext.dart';
import 'package:f_router/route/route.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/second_page.dart';

List<BasePage> _initPages = [];

class AppRouterInfo with RouteInfo {
  /// 处理路由
  @override
  GetRouteStatus get routeStatus => (MaterialPage page) {
        if (page.child is HomePageWidget) {
          return RouteStatus.home;
        } else if (page.child is LoginPage) {
          return RouteStatus.login;
        } else {
          return RouteStatus.unknown;
        }
      };

  /// 注册表
  /// 注册表可以容易得同一管理页面
  /// 问题： 启动会一次性初始化 页面多了会造成卡顿
  /// 解决一次性的卡顿的思路 ---- 用到再初始化
  @override
  List<BasePage> get pages =>

      /// 解决 多次调用的初始化的问题
      _initPages.isNullOrEmpty() ? (_initPages = getPages()) : _initPages;

  getPages() {
    return [
      // // HomePage(),
      // PageFactor.create(
      //   RouteStatus.home,
      //   HomePageWidget(title: "home"),
      // ),
      // PageFactor.create(
      //   RouteStatus.login,
      //   LoginPage(),
      // ),
    ];
  }

  /// 解决注册表一次性初始化的问题
  @override
  BasePage? getPage(RouteStatus status) {
    BasePage? page;
    if (status == RouteStatus.home) {
      page = PageFactor.create(
        RouteStatus.home,
        HomePageWidget(title: "home"),
      );
    } else if (status == RouteStatus.login) {
      page = PageFactor.create(
        RouteStatus.login,
        LoginPage(),
      );
    } else if (status == RouteStatus.registration) {
    } else if (status == RouteStatus.detail) {
    } else {}
    return page;
  }

  @override
  RouteStatus? intercept(RouteStatus currentStatus) {
    return null;
  }
}
