import 'package:f_router/base/base_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends BaseStatefulWidget {
  LoginPage({super.key}){
    print("LoginPage  构造............");
  }
  @override
  void initState() {
    super.initState();
    print("initState  LoginPage............");
  }
  @override
  BuildWidget get buildWidget => (context) {
        var args = arguments;
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Second page:$args',
                ),
                Text(
                  '$args',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      };
}
