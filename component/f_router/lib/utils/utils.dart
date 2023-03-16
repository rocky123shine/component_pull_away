import 'package:flutter/material.dart';
/// name 是page 的唯一标识  可以用常量表示 arguments 传参
MaterialPage wrapPage(Widget child, String? name, {Object? agrs}) {
  return MaterialPage(
      key: ValueKey(child.hashCode), child: child, name: name, arguments: agrs);
}

// class Log {
//   static const String _TAG_DEFAULT = "******LOG******";
//   static bool debug = false;
//   static String TAG = _TAG_DEFAULT;
//
//   static void initLog({bool isDebug = false, String tag = _TAG_DEFAULT}) {
//     debug = isDebug;
//     TAG = tag;
//   }
//
// }
