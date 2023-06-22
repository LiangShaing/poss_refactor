package com.example.poss_mobile_app.plugin.tpns;

import android.content.Context;
import android.text.TextUtils;

import com.example.poss_mobile_app.MainActivity;
import com.tencent.android.tpush.XGPushBaseReceiver;
import com.tencent.android.tpush.XGPushClickedResult;
import com.tencent.android.tpush.XGPushRegisterResult;
import com.tencent.android.tpush.XGPushShowedResult;
import com.tencent.android.tpush.XGPushTextMessage;

import io.flutter.Log;

public class XGMessageReceiver extends XGPushBaseReceiver {

    private static String TAG = "XGMessageReceiver";

    private int retryMax = 3; //重新call method max次數

    @Override
    public void onRegisterResult(Context context, int i, XGPushRegisterResult xgPushRegisterResult) {
        Log.d(TAG,"onRegisterResult");
        FlutterNotificationPlugin.newRelicNotification("XGMessageReceiver onRegisterResult");
        try {
            FlutterNotificationPlugin _instance = FlutterNotificationPlugin.getInstance();
            if (_instance == null) {
                MainActivity.newRelicErr("XgFlutterPlugin.instance has not initialized");
                return;
            }
            if (context == null || xgPushRegisterResult == null) {
                String msg = "TPNS token: null" + " error: context==null||message == null";
                MainActivity.newRelicErr(msg);
                return;
            }
            if (i == XGPushBaseReceiver.SUCCESS) {
                String deviceToken = xgPushRegisterResult.getToken();
                if (!TextUtils.isEmpty(deviceToken)) {
                    _instance.toFlutterMethod("setDeviceToken",deviceToken);
                }
            } else {
                MainActivity.newRelicErr("TPNS token: " + xgPushRegisterResult.getToken() + " error: " + i);
            }
        }catch (Exception error){
            Log.e(TAG, error.getMessage());
            MainActivity.newRelicErr(error.getMessage());
        }
    }

    @Override
    public void onUnregisterResult(Context context, int i) {
        Log.d(TAG,"onUnregisterResult");
    }

    @Override
    public void onSetTagResult(Context context, int i, String s) {
        Log.d(TAG,"onSetTagResult");
    }

    @Override
    public void onDeleteTagResult(Context context, int i, String s) {
        Log.d(TAG,"onDeleteTagResult");
    }

    @Override
    public void onSetAccountResult(Context context, int i, String s) {
        Log.d(TAG,"onSetAccountResult");
    }

    @Override
    public void onDeleteAccountResult(Context context, int i, String s) {
        Log.d(TAG,"onDeleteAccountResult");
    }

    @Override
    public void onSetAttributeResult(Context context, int i, String s) {
        Log.d(TAG,"onSetAttributeResult");
    }

    @Override
    public void onQueryTagsResult(Context context, int i, String s, String s1) {
        Log.d(TAG,"onQueryTagsResult");
    }

    @Override
    public void onDeleteAttributeResult(Context context, int i, String s) {
        Log.d(TAG,"onDeleteAttributeResult");
    }

    @Override
    public void onTextMessage(Context context, XGPushTextMessage xgPushTextMessage) {
        Log.d(TAG,"XGMessageReceiver onTextMessage");
        FlutterNotificationPlugin.newRelicNotification("XGMessageReceiver onTextMessage");
        sendMessageToFlutterPlugin(xgPushTextMessage.getCustomContent(),0);
    }

    @Override
    public void onNotificationClickedResult(Context context, XGPushClickedResult xgPushClickedResult) {
        Log.d(TAG,"XGMessageReceiver onNotificationClickedResult");
        FlutterNotificationPlugin.newRelicNotification("XGMessageReceiver onNotificationClickedResult getActionType:"+xgPushClickedResult.getActionType());
        //0 表示该通知被点击，2 表示该通知被清除
        if(xgPushClickedResult.getActionType() == 2){
            return;
        }
        sendMessageToFlutterPlugin(xgPushClickedResult.getCustomContent(),0);
    }

    @Override
    public void onNotificationShowedResult(Context context, XGPushShowedResult xgPushShowedResult) {
        Log.d(TAG,"onNotificationShowedResult");
        FlutterNotificationPlugin.newRelicNotification("XGMessageReceiver onNotificationShowedResult");
    }

    //將推播訊息傳給FlutterPlugin
    public void sendMessageToFlutterPlugin(String message, int retry){
        Log.d(TAG,String.format("sendMessageToFlutterPlugin retry: %s",retry));
        FlutterNotificationPlugin.newRelicNotification(String.format("XGMessageReceiver sendMessageToFlutterPlugin retry: %s",retry));
        FlutterNotificationPlugin flutterNotificationPlugin = FlutterNotificationPlugin.getInstance();
        if(null == flutterNotificationPlugin){
            Log.d(TAG,"sendMessageToFlutterPlugin FlutterNotificationPlugin null");
            FlutterNotificationPlugin.newRelicNotification("XGMessageReceiver sendMessageToFlutterPlugin FlutterNotificationPlugin null");
            if(retry > retryMax){ return; }
            retry++;
            int finalRetry = retry;
            MainHandler.getInstance().postDelayed(new Runnable() {
                @Override
                public void run() {
                    sendMessageToFlutterPlugin(message, finalRetry);
                }
            },1000);
            return;
        }
        flutterNotificationPlugin.toFlutterMethod("xgNotificationResultCustomContent",message);
    }


}
