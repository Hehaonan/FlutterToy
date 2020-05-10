package com.flutter.hhn.toy.plugin.basic;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** PluginRegistrant */
public class PluginRegistrant implements MethodCallHandler {
    /** Plugin registration. */
    public static void registerWith(Registrar registrar) {
        PluginManager.registerWith(registrar);
        PluginViewManager.registerWith(registrar);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("")) {
            result.notImplemented();
        }
    }
}
