import 'package:f_router/base/base_widget.dart';
import 'package:f_router/utils/utils.dart';
import 'package:flutter/material.dart';

import '../route/route.dart';

abstract class BasePage {
  Object? args;

  BasePage({this.args});

  RouteStatus get routeStatus;

  MaterialPage? get page;
}

class AppPage extends BasePage {
  @override
  MaterialPage? page;
  Widget child;
  @override
  RouteStatus routeStatus;

  AppPage(this.child, this.routeStatus, {super.args}) {
    if (child is BuildWidgetMixin) (child as BuildWidgetMixin).args = args;
    page = wrapPage(child, routeStatus.name);
  }
}

class PageFactor {
  static BasePage create(RouteStatus status, Widget child, {Object? args}) {
    return AppPage(child, status, args: args);
  }
}

class PageInfo {
  final RouteStatus routeStatus;
  final Widget page;

  PageInfo(this.routeStatus, this.page);
}
