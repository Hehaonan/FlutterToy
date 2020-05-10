import 'package:flutter/material.dart';

class Utils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void showSnackBar(ScaffoldState scaffoldState, String msg) {
    if (null != scaffoldState) {
      final snackBar = SnackBar(
        content: Text(msg),
        //action: SnackBarAction(label: 'label', onPressed: () => {}),
      );
      scaffoldState.showSnackBar(snackBar);
    }
  }
}
