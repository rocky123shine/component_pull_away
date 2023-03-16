import 'package:flutter/cupertino.dart';

typedef OnResume = Function();
typedef OnPause = Function();

class PageChangeListener {
  OnResume onResume;
  OnPause onPause;
  Widget widget;

  PageChangeListener(this.widget,
      {required this.onResume, required this.onPause});
}
