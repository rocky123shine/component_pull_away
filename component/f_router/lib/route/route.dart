
import 'package:flutter/material.dart';

import '../../base/base_page.dart';

///自定义路由封装，路由状态
enum RouteStatus { login, registration, home, detail, unknown, target, target2 }

typedef GetRouteStatus = RouteStatus Function(MaterialPage page);

mixin RouteInfo {
  GetRouteStatus get routeStatus;

  ///See [getPage]
  @Deprecated("一次性注册造成一次性初始化")
  List<BasePage> get pages;

  BasePage? getPage(RouteStatus status);

  RouteStatus interceptRouteStatus(RouteStatus currentStatus) {
    return intercept(currentStatus) ?? currentStatus;
  }

  ///  在这里拦截路由
  /// 如 判断是否登录 需要登录 未登录 则直接返回 RouteStatus.login
  RouteStatus? intercept(RouteStatus currentStatus);
}