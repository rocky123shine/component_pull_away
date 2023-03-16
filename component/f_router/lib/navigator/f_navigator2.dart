import 'package:f_router/base/base_page.dart';
import 'package:f_router/navigator/router_delegate.dart';
import 'package:flutter/material.dart';

import '../listener/page_change_listener.dart';
import '../listener/route_jump_listener.dart';
import '../route/route.dart';
import '../utils/log.dart';

class FNavigator {
  FNavigator._();

  static FNavigator? _instance;
  RouteJumpListener? _routeJumpListener;
  FRouterDelegate? _delegate;
  final List<PageChangeListener> _pageChangeListeners = [];

  /// 实现单例唯一
  static FNavigator get instance {
    _instance ??= FNavigator._();
    return _instance!;
  }

  /// 提供RouterDelegate 并注册首页
  /// 注意不要 [ MaterialApp.router]  否则 物理返回键 有效果 但是 当前 界面一直被重新加载
  FRouterDelegate routerDelegate(RouteInfo routeStatusInfo) {
    return _delegate ??= FRouterDelegate(routeStatusInfo);
  }

  ///页面 跳转
  ///具体的实现
  /// 点击跳转 触发跳转的监听
  /// 定义监听
  /// class RouteJumpListener {
  ///     final OnJumpTo onJumpTo;
  ///
  ///     RouteJumpListener({required this.onJumpTo});
  /// }
  void jumpTo(RouteStatus routeStatus, {Map? args}) {
    _routeJumpListener?.onJumpTo(routeStatus, args: args);
  }

  /// 注册监听
  void registerRouteJumpListener(RouteJumpListener listener) {
    _routeJumpListener = listener;
  }

  /// 注意添加和移除成对出现
  /// 在 widget dispose 的时候移除
  /// 移除[removePageChangeListener]
  void addPageChangeListener(PageChangeListener listener) {
    if (!_pageChangeListeners.contains(listener)) {
      _pageChangeListeners.add(listener);
    }
  }

  void removePageChangeListener(PageChangeListener listener) {
    _pageChangeListeners.remove(listener);
  }

  /// 监听页面的生命周期变化 模拟Android的onResume 和 onPause
  void notify(List<MaterialPage<dynamic>> currentPages,
      List<MaterialPage<dynamic>> prePages) {
    if (currentPages == prePages) return;
    var current = PageInfo(
        _delegate!.getRouteStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  ///记录当前页面
  var _current;

  /// 通知所有监听者
  void _notify(PageInfo current) {
    for (var listener in _pageChangeListeners) {
      if (current.page == listener.widget) {
        Log.d("${listener.widget.toStringShort()} onResume call ......");

        listener.onResume();
        break;
      } else if (_current.page == listener.widget) {
        Log.d("${listener.widget.toStringShort()}  onPause call ......");
        listener.onPause();
        break;
      }
    }

    ///注意更新当前页面
    _current = current;
  }
}
