import 'package:flutter/material.dart';
import 'package:flutter_toy_example/page/first_page.dart';
import 'package:flutter_toy_example/page/gesture_page.dart';
import 'package:flutter_toy_example/page/layout_page.dart';
import 'package:flutter_toy_example/page/lifecycle_page.dart';
import 'package:flutter_toy_example/page/plugin_view_page.dart';

class MyRoutes {
  static Map<String, String> routes = {
    'FlutterFisrtPage': '/first_page',
    'LayoutDemo': '/layout_page',
    'GuestureDemo': '/gesture_page',
    'PluginViewDemo': '/plugin_view_page',
    'LifecycleDemo': '/lifecycle_page',
  };

  static Map<String, WidgetBuilder> getRoute(context) {
    return {
      '/layout_page': (BuildContext context) => LayoutPage(),
      '/first_page': (BuildContext context) => FirstPage(),
      '/gesture_page': (BuildContext context) => GesturePage(),
      '/plugin_view_page': (BuildContext context) => PluginViewPage(),
      '/lifecycle_page': (BuildContext context) => LifecyclePage(),
    };
  }
}
