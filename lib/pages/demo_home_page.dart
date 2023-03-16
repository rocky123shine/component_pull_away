import 'package:f_router/navigator/f_navigator2.dart';
import 'package:f_router/route/route.dart';
import 'package:flutter/material.dart';

class DemoHomePage extends StatefulWidget {
  DemoHomePage({Key? key}) : super(key: key){
    print("DemoHomePage 构造");
  }

  @override
  State<DemoHomePage> createState() => _DemoHomePageState();
}

class _DemoHomePageState extends State<DemoHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("主页"),
            MaterialButton(
              onPressed: () {
                Map args = {"data": "这个是数据..."};
                FNavigator.instance
                    .jumpTo(RouteStatus.target2, args: args);
              },
              child: Text("跳转"),
            )
          ],
        ),
      ),
    );
  }
}
