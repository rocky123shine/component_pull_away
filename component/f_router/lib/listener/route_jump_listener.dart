import '../route/route.dart';

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

/// 统一处理跳转事件
/// 在RouterDelegate 注册监听，
/// 自动调用  notifyListeners();
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({required this.onJumpTo});
}
