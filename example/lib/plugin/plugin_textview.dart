import 'dart:async';

import 'package:flutter/services.dart';

class PluginTextView {
  static const MethodChannel _channel = const MethodChannel('plugin_textview');

  static MethodChannel get channel => _channel;

  static Future<String> getPlatformVersion() async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
