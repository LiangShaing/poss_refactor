package com.example.poss_mobile_app;


import android.content.Context;
import android.os.Bundle;
import android.view.WindowManager;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.Log;

import com.example.poss_mobile_app.plugin.tpns.FlutterNotificationPlugin;
import com.github.javiersantos.appupdater.AppUpdaterUtils;
import com.github.javiersantos.appupdater.enums.AppUpdaterError;
import com.github.javiersantos.appupdater.enums.UpdateFrom;
import com.github.javiersantos.appupdater.objects.Update;
import com.newrelic.agent.android.NewRelic;
import com.example.poss_mobile_app.plugin.FlutterNewRelicPlugin;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterFragmentActivity;

public class MainActivity extends FlutterFragmentActivity {
    private static String TAG = "MainActivity";

    private static Context mContext;
    private String downloadUrl = "";

    public static Context getContext() {
        return mContext;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mContext = this;
        Log.d(TAG, "NEWRELIC_TOKEN: " + BuildConfig.NEWRELIC_TOKEN);
        NewRelic.withApplicationToken(BuildConfig.NEWRELIC_TOKEN).start(mContext);
        Language.initLanguage();
        /*if(!BuildConfig.DEBUG){ //開發中 不判斷提醒更新視窗
            checkUpdate();
        }*/
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        FlutterNewRelicPlugin.registerWith(flutterEngine);
        FlutterNotificationPlugin.registerWith(flutterEngine);
        FlutterWindowManager.registerWith(flutterEngine, getWindow());
    }

    public void checkUpdate() {
        String url = BuildConfig.CHECK_VERSION_URL + "?v=" + System.currentTimeMillis();
        AppUpdaterUtils appUpdaterUtils = new AppUpdaterUtils(mContext)
                .setUpdateFrom(UpdateFrom.JSON)
                .setUpdateJSON(url)
                .withListener(new AppUpdaterUtils.UpdateListener() {
                    @Override
                    public void onSuccess(Update update, Boolean isUpdateAvailable) {
                        if (isUpdateAvailable) {
                            downloadUrl = update.getUrlToDownload().toString();
                            if (downloadUrl != null && !downloadUrl.isEmpty()) {
                                try {
                                    JSONObject object = new JSONObject();
                                    object.put("type", "check_version");
                                    object.put("downloadUrl", downloadUrl);
                                    new ShowAlertDialogAsyncTask().execute(object.toString());
                                } catch (Exception error) {
                                    MainActivity.newRelicErr("AppUpdaterError:" + error.getMessage());
                                    Log.e(TAG, error.getMessage());
                                }
                            } else {
                                MainActivity.newRelicErr("AppUpdaterError downloadUrl empty");
                                Log.e(TAG, "downloadUrl empty");
                            }
                        }
                    }

                    @Override
                    public void onFailed(AppUpdaterError error) {
                        newRelicErr("AppUpdaterError " + error.toString());
                        Log.e(TAG, "AppUpdaterError " + error.toString());
                    }
                });
        appUpdaterUtils.start();
    }

    public static void newRelicErr(String errorMessage) {
        try {
            Map attributes = new HashMap();
            attributes.put("errorMessage", errorMessage);
            attributes.put("appProjectName", "MobilePossApp");
            NewRelic.recordCustomEvent("FTError", attributes);
        } catch (Exception e) {
            e.printStackTrace();
            NewRelic.recordHandledException(e);
        }
    }

}

