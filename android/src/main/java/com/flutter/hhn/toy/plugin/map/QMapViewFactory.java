package com.flutter.hhn.toy.plugin.map;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

/**
 * Author: haonan.he ;<p/>
 * Date: 2019-09-01,11:36 ;<p/>
 * Description: ;<p/>
 * Other: ;
 */
public class QMapViewFactory extends PlatformViewFactory {

    private PluginRegistry.Registrar mRegistrar;

    public QMapViewFactory(PluginRegistry.Registrar registrar) {
        super(new StandardMessageCodec());
        mRegistrar = registrar;
    }

    @Override
    public PlatformView create(final Context context, int id, Object o) {
        Map<String, Object> params = (Map<String, Object>) o;
        return new MyTextView(mRegistrar, id, params);
    }
}