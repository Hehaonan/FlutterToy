package com.flutter.hhn.toy.plugin.map;

import android.graphics.Color;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.flutter.hhn.toy.plugin.basic.PluginManager;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.platform.PlatformView;

/**
 * Author: haonan.he ;<p/>
 * Date: 2019-09-20,20:52 ;<p/>
 * Description: ;<p/>
 * Other: ;
 */
public class MyTextView implements PlatformView, MethodChannel.MethodCallHandler {
    private TextView mTextView;
    private MethodChannel methodChannel;

    private PluginRegistry.Registrar mRegistrar;

    MyTextView(final PluginRegistry.Registrar registrar, int id, Map<String, Object> params) {
        this.mRegistrar = registrar;
        TextView mTextView = new TextView(registrar.context());
        mTextView.setText("我是来自Android的原生TextView");
        mTextView.setBackgroundColor(Color.rgb(155, 205, 155));
        mTextView.setTextColor(Color.WHITE);
        mTextView.setGravity(Gravity.CENTER);
        mTextView.setTextSize(16.0f);
        if (params != null && params.containsKey("method_text_str")) {
            mTextView.setText(params.get("method_text_str").toString());
        }
        this.mTextView = mTextView;

        methodChannel = new MethodChannel(mRegistrar.messenger(), "plugin_textview");
        methodChannel.setMethodCallHandler(new PluginManager.MethodCallHandlerWrapper(this));

        mTextView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                methodChannel.invokeMethod("viewClick", "form native：点击事件！");
                Toast.makeText(registrar.context(), "Click NativeToast!", Toast.LENGTH_SHORT).show();
            }
        });
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        if (methodCall.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public View getView() {
        return mTextView;
    }

    @Override
    public void dispose() {
        methodChannel.setMethodCallHandler(null);
    }
}
