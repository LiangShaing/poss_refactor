package com.example.poss_mobile_app;

import android.app.Activity;
import android.view.Window;
import android.view.WindowManager;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * FlutterWindowManager
 */
public class FlutterWindowManager implements FlutterPlugin,
        MethodChannel.MethodCallHandler {

    private MethodChannel channel;
    private static MethodChannel.Result result;
    private Activity activity;
    private static Window window;

    public static void registerWith(@NonNull FlutterEngine flutterEngine, @NonNull Window activityWindow) {
        window = activityWindow;
        flutterEngine.getPlugins().add(new FlutterWindowManager());
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_window_manager");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, MethodChannel.Result result) {

        FlutterWindowManager.result = result;
        switch (call.method) {
            case "secureFlag":
                this.secureFlag();
                break;
            case "clearSecureFlag":
                this.clearSecureFlag();
                break;
            default:
                result.error("Error", "call method error", null);
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }

    //Screen secure
    private void secureFlag() {
        window.setFlags(WindowManager.LayoutParams.FLAG_SECURE, WindowManager.LayoutParams.FLAG_SECURE);
    }

    //Screen secure
    private void clearSecureFlag() {
        window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE);
    }

}
