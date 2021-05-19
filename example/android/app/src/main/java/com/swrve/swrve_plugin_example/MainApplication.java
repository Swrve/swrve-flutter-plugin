package com.swrve.swrve_plugin_example;

import android.util.Log;

import com.swrve.sdk.SwrveSDK;
import com.swrve.sdk.config.SwrveConfig;

import io.flutter.app.FlutterApplication;

public class MainApplication extends FlutterApplication {
    public void onCreate() {
        super.onCreate();
        try {
            SwrveConfig config = new SwrveConfig();
            // To use the EU stack, include this in your config.
            // config.setSelectedStack(SwrveStack.EU);
            SwrveSDK.createInstance(this, <app id>, "<api key>", config);
        } catch (IllegalArgumentException exp) {
            Log.e("SwrveDemo", "Could not initialize the Swrve SDK", exp);
        }
    }
}
