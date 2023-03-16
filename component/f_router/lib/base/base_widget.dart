import 'package:flutter/widgets.dart';

typedef BuildWidget = Widget Function(BuildContext context);

mixin BuildWidgetMixin {
  //提供 传参入口
  Object? args;

  Object? get arguments;

  BuildWidget get buildWidget;
}
mixin WidgetInitStateMixin {
  void initState() {}
}

abstract class BaseStatefulWidget extends StatefulWidget
    with BuildWidgetMixin, WidgetInitStateMixin {
  BaseStatefulWidget({super.key});

  @override
  State<StatefulWidget> createState() => _BaseStatefulWidgetState();

  @override
  Object? get arguments => args;
}

class _BaseStatefulWidgetState extends State {
  @override
  void initState() {
    super.initState();
    (widget as BaseStatefulWidget).initState();
  }

  @override
  Widget build(BuildContext context) =>
      (widget as BaseStatefulWidget).buildWidget(context);
}

abstract class BaseStatelessWidget<W> extends StatelessWidget
    with BuildWidgetMixin {
  BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) => buildWidget(context);

  @override
  Object? get arguments => args;
}
