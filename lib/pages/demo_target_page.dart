import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DemoTargetPage extends StatefulWidget {
  const DemoTargetPage({Key? key}) : super(key: key);

  @override
  State<DemoTargetPage> createState() => _DemoTargetPageState();
}

class _DemoTargetPageState extends State<DemoTargetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [Text("测试页面"), MaterialButton(onPressed: () {})],
        ),
      ),
    );
  }
}
