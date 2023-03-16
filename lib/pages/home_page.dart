import 'package:f_router/base/base_page.dart';
import 'package:f_router/listener/page_change_listener.dart';
import 'package:f_router/navigator/f_navigator2.dart';
import 'package:f_router/route/route.dart';
import 'package:f_router/utils/utils.dart';

import 'package:flutter/material.dart';

class HomePage extends BasePage {
  @override
  MaterialPage? get page => wrapPage(
      HomePageWidget(
        title: 'home',
      ),
      RouteStatus.home.name);

  @override
  RouteStatus get routeStatus => RouteStatus.home;
}

class HomePageWidget extends StatefulWidget {
  HomePageWidget({super.key, required this.title}) {
    print("HomePageWidget 构造。。。$hashCode");
  }

  late String title;

  @override
  State<HomePageWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  var pageListener;

  @override
  void initState() {
    super.initState();
    pageListener = PageChangeListener(widget, onResume: () {}, onPause: () {});
    FNavigator.instance.addPageChangeListener(pageListener);
  }

  @override
  void dispose() {
    super.dispose();
    FNavigator.instance.removePageChangeListener(pageListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            MaterialButton(
              onPressed: () {
                Map args111 = <String, String>{};
                args111["args"] = "hahahahha";
                // FNavigator.instance.jumpTo(
                //     wrapPage(SecondPage(title: "", args: args111), "scond"));
                FNavigator.instance.jumpTo(RouteStatus.login, args: args111);
              },
              color: Colors.blueAccent,
              child: const Text("jump"),
            )
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
