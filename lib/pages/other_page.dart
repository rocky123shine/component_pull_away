import 'package:f_router/base/base_widget.dart';
import 'package:flutter/material.dart';

class OtherPageWidget extends BaseStatefulWidget {
  OtherPageWidget({super.key});

  @override
  void initState() {
    super.initState();
    print("initState ............");
  }

  // @override
  // // TODO: implement buildWidget
  // BuildWidget get buildWidget => (context){ return const Text("");} ;

  @override
  BuildWidget get buildWidget => (context) {
        return const Center(
          child: Text("Center ............"),
        );
      };
}
