package com.flutter.hhn.toy.plugin.basic;

import io.flutter.plugin.common.MethodChannel;


public interface BasePlugin extends MethodChannel.MethodCallHandler {

    String getPluginName();

}
