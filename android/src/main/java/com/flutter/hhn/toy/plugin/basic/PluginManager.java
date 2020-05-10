package com.flutter.hhn.toy.plugin.basic;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import static com.flutter.hhn.toy.utils.Const.PLUGIN_NAME_SPACE;

/**
 * Author: haonan.he ;<p/>
 * Date: 2019-09-20,16:42 ;<p/>
 * Description: ;<p/>
 * Other: ;
 */
public class PluginManager {

    public static void registerWith(Registrar registrar) {
    }

    private static void register(Registrar registrar, BasePlugin plugin) {
        MethodChannel channel = new MethodChannel(registrar.messenger(), PLUGIN_NAME_SPACE + plugin.getPluginName());
        channel.setMethodCallHandler(new MethodCallHandlerWrapper(plugin));
    }

    public static class MethodCallHandlerWrapper implements MethodCallHandler {
        private MethodCallHandler callHandler;

        public MethodCallHandlerWrapper(MethodCallHandler callHandler) {
            this.callHandler = callHandler;
        }

        @Override
        public void onMethodCall(MethodCall methodCall, Result result) {
            // TODO: 2019-07-27 插件整体处理 错误上传 参数预处理等
            callHandler.onMethodCall(methodCall, result);
        }
    }

}
