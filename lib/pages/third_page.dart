import 'package:flutter/material.dart';

class ThirdPage extends Page {
  @override
  // TODO: implement name
  String? get name => "Third";
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this,
        builder: (context) {
          return Container(
            width: 1,
            height: 1,
            alignment: Alignment.center,
            child: const Text("ThirdPage"),
          );
        });
  }
}
