package com.flutter.hhn.toy.plugin.basic;


import com.flutter.hhn.toy.plugin.map.QMapViewFactory;

import io.flutter.plugin.common.PluginRegistry;

/**
 * Author: haonan.he ;<p/>
 * Date: 2019-09-01,11:54 ;<p/>
 * Description: ;<p/>
 * Other: ;
 */
public class PluginViewManager {

    private static final String KEY_QMAPVIEW = "QMapView";

    public static void registerWith(PluginRegistry.Registrar registrar) {
        registerQMapView(registrar);
    }

    private static void registerQMapView(PluginRegistry.Registrar registrar) {
        if (null != registrar) {
            registrar.platformViewRegistry().registerViewFactory(KEY_QMAPVIEW, new QMapViewFactory(registrar));
        }
    }

}
