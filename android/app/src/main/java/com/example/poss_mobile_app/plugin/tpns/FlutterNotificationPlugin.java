package com.example.poss_mobile_app.plugin.tpns;

import android.app.Activity;

import android.app.Notification;
import android.content.Context;

import android.content.SharedPreferences;


import androidx.annotation.NonNull;

import com.example.poss_mobile_app.BuildConfig;
import com.example.poss_mobile_app.MainActivity;
import com.example.poss_mobile_app.R;
import com.example.poss_mobile_app.ShowAlertDialogAsyncTask;
import com.newrelic.agent.android.NewRelic;
import com.tencent.android.tpush.XGCustomPushNotificationBuilder;
import com.tencent.android.tpush.XGIOperateCallback;
import com.tencent.android.tpush.XGPushConfig;
import com.tencent.android.tpush.XGPushManager;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import io.flutter.Log;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class FlutterNotificationPlugin implements FlutterPlugin,
        ActivityAware,
        MethodChannel.MethodCallHandler,
        EventChannel.StreamHandler{

    private static String TAG = "FlutterNotificationPlugin";
    MethodChannel methodChannel;
    MethodChannel.Result result;
    EventChannel eventChannel;
    EventChannel.EventSink eventSink;
    Context context;
    Activity activity;
    String message=""; //存放notification 帶過來message 資料
    String deviceToken = "";
    int badgeNumber = 0; //未讀數,目前尚無未讀功能,預設先給1
    static FlutterNotificationPlugin instance;

    public static FlutterNotificationPlugin getInstance(){
        return FlutterNotificationPlugin.instance;
    }

    public static void registerWith(FlutterEngine flutterEngine){
        Log.d(TAG,"registerWith");
        if(null == instance){
            FlutterNotificationPlugin.instance = new FlutterNotificationPlugin();
        }
        flutterEngine.getPlugins().add(FlutterNotificationPlugin.instance);
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        Log.d(TAG,"onAttachedToEngine");
        context = binding.getApplicationContext();
        this.methodChannel = new MethodChannel(binding.getBinaryMessenger(), "flutter_notification");
        this.methodChannel.setMethodCallHandler(this);
        this.eventChannel = new EventChannel(binding.getBinaryMessenger(), "flutter_notification_event");
        this.eventChannel.setStreamHandler(this);
        this.message = "";
        this.registerTPNSPush();
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        Log.d(TAG,"onDetachedFromEngine");
    }

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        Log.d(TAG,"onAttachedToActivity");
        this.activity = binding.getActivity();
        this.isFirstLaunch();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        Log.d(TAG,"onDetachedFromActivityForConfigChanges");
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        Log.d(TAG,"onReattachedToActivityForConfigChanges");
        this.activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        Log.d(TAG,"onDetachedFromActivity");
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Log.d(TAG,String.format("onMethod : %s",call.method));
        FlutterNotificationPlugin.newRelicNotification(String.format("onMethod : %s",call.method));
        this.result = result;
        switch (call.method){
            case "getDeviceToken":
                this.getDeviceToken();
                break;
            case "eventGetDeviceToken":
                this.eventGetDeviceToken();
                break;
            case "clearDeviceToken":
                this.clearDeviceToken();
                break;
            case "eventGetNotificationRouterMessage":
                this.eventGetNotificationRouterMessage();
                break;
            case "getApplicationIconBadgeNumber":
                this.getApplicationIconBadgeNumber();
                break;
            case "updateApplicationIconBadgeNumber":
                this.updateApplicationIconBadgeNumber(call);
                break;
            case "clearNotificationRouterMessage":
                this.clearNotificationRouterMessage();
                break;
            case "getNotificationPermission":
                this.getNotificationPermission();
                break;
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        Log.d(TAG,"onListen");
        this.eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        Log.d(TAG,"onCancel");
    }

    /**
     * 取得deviceToken
     */
    private void eventGetDeviceToken() {
        this._sendDeviceToken();
    }

    /**
     * 取得推播傳遞訊息
     */
    private void eventGetNotificationRouterMessage() {
        try {
            Log.d(TAG,"eventGetNotificationRouterMessage");
            if(this.eventSink == null){
                FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin eventGetNotificationRouterMessage message null");
                Log.e(TAG, "eventGetNotificationRouterMessage eventSink null");
                return;
            }else if(this.message.isEmpty()){
                FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin eventGetNotificationRouterMessage message empty");
                Log.e(TAG, "eventGetNotificationRouterMessage message empty");
                return;
            }

            JSONObject jsonObject = new JSONObject();
            jsonObject.put("notificationType","routerMessage");
            jsonObject.put("content",this.message);
            this.eventSink.success(jsonObject.toString());
        }catch (Exception error){
            MainActivity.newRelicErr(error.getMessage());
            Log.e(TAG, error.getMessage());
        }
    }

    /**
     * 儲存 deviceToken
     * @param deviceToken
     */
    public void setDeviceToken(String deviceToken){
        this.deviceToken = deviceToken;
    }

    /**
     * 取得device token
     */
    private void getDeviceToken() {
        try {
            if(this.deviceToken.isEmpty()){
                MainActivity.newRelicErr("FlutterNotificationPlugin getDeviceToken deviceToken empty");
                this.result.success("");
            }else{
                this.result.success(this.deviceToken);
            }
        }catch (Exception error){
            Log.e(TAG, error.getMessage());
            this.result.error("Error",error.getMessage(),null);
        }
    }

    private void _sendDeviceToken() {
        try {
            if(this.deviceToken.isEmpty()){
                Log.e(TAG,"deviceToken empty");
                FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin deviceToken empty");
                return;
            }else if(this.eventSink == null){
                Log.e(TAG,"eventSink empty");
                FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin eventSink empty");
                return;
            }else if(!XGPushManager.isNotificationOpened(context)){
                Log.e(TAG,"isNotificationOpened false");
                FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin isNotificationOpened false");
                return;
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("notificationType","deviceToken");
            jsonObject.put("content", this.deviceToken);
            this.eventSink.success(jsonObject.toString());
        }catch (Exception error){
            MainActivity.newRelicErr(error.getMessage());
            Log.e(TAG,error.getMessage());
        }
    }

    /**
     * 清除token
     */
    private void clearDeviceToken(){
        this.deviceToken = "";
    }

    /**
     * 取得未讀數 (目前尚無功能)
     */
    private void getApplicationIconBadgeNumber(){
        if(this.result == null){
            Log.e(TAG, "result null");
            return;
        }
        this.result.success(this.badgeNumber);
    }

    private void _sendBadgeNumber() {
        try {
            if(this.eventSink == null){
                Log.e(TAG,"eventSink empty");
                return;
            }else if(this.badgeNumber<=0){
                Log.e(TAG,"badgeNumber <= 0");
                return;
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("notificationType","badgeNumber");
            jsonObject.put("content", String.valueOf(this.badgeNumber));
            this.eventSink.success(jsonObject.toString());
        }catch (Exception error){
            MainActivity.newRelicErr(error.getMessage());
            Log.e(TAG,error.getMessage());
        }
    }

    /**
     * 更新未讀數 (目前尚無功能)
     */
    private void updateApplicationIconBadgeNumber(MethodCall call){
        try {
            Map<String, Object> arguments = call.arguments();
            if(!arguments.containsKey("number")){
                this.result.error("Error","updateApplicationIconBadgeNumber number not find",null);
                return;
            }
            int number = (int) arguments.get("number");
            Log.d(TAG,String.format("updateApplicationIconBadgeNumber number: %s",number));
            this.badgeNumber = number;
        }catch (Exception error){
            MainActivity.newRelicErr(error.getMessage());
            Log.e(TAG,error.getMessage());
        }
    }

    /**
     * 清空router 資訊
     */
    private void clearNotificationRouterMessage(){
        this.message = "";
    }

    /**
     * event router
     * @param jsonString
     */
    public void xgNotificationResultCustomContent(String jsonString){
        Log.d(TAG,"xgNotificationResultCustomContent jsonString:"+jsonString);
        if(jsonString.isEmpty()){
            FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin xgNotificationResultCustomContent jsonString empty");
            return;
        }
        this.message = jsonString;
        this.eventGetNotificationRouterMessage();
    }

    /**
     * handle flutter plugin
     * @param funName
     * @param data
     */
    public void toFlutterMethod(String funName, String data){
        try {
            Log.d(TAG,String.format("FlutterNotificationPlugin toFlutterMethod funName:%s data: %s",funName,data));
            FlutterNotificationPlugin.newRelicNotification(String.format("FlutterNotificationPlugin toFlutterMethod funName:%s data: %s",funName,data));
            MainHandler.getInstance().post(new Runnable() {
                @Override
                public void run() {
                    switch (funName){
                        case "xgNotificationResultCustomContent":
                            instance.xgNotificationResultCustomContent(data);
                            break;
                        case "setDeviceToken":
                            instance.setDeviceToken(data);
                            break;
                    }
                }
            });
        }catch (Exception error){
            MainActivity.newRelicErr(error.getMessage());
            Log.e(TAG,error.getMessage());
        }
    }

    /**
     * Register TPNS PUSH
     */
    public void registerTPNSPush(){
        Log.d(TAG,"initTPNSPush");
        new Thread(new Runnable() {
            @Override
            public void run() {
                FlutterNotificationPlugin _instance = FlutterNotificationPlugin.getInstance();
                _instance.configTPNS();
                XGPushManager.registerPush(context, new XGIOperateCallback() {
                    @Override
                    public void onSuccess(Object data, int flag) {
                        Log.d(TAG, "FlutterNotificationPlugin TPush Registration succeeded. Device token: " + data.toString());
                        FlutterNotificationPlugin.newRelicNotification("FlutterNotificationPlugin TPush Registration succeeded.");
                        String deviceToken = data.toString();
                        _instance.setDeviceToken(deviceToken);
                    }
                    @Override
                    public void onFail(Object data, int errCode, String msg) {
                        Log.d(TAG, "FlutterNotificationPlugin TPush Registration failed. Error code: " + errCode + ", error message: " + msg);
                        MainActivity.newRelicErr("FlutterNotificationPlugin TPush Registration failed. Error code: " + errCode + ", error message: " + msg);
                    }
                });
                _instance.initCustomPushNotificationBuilder(context);
            }
        }).start();
    }

    /**
     * config TPNS
     */
    public void configTPNS(){
        Log.d(TAG,"configTPNS");
        XGPushConfig.setReportNotificationStatusEnable(context,true);
        XGPushConfig.enablePullUpOtherApp(context, false);
        XGPushConfig.enableAutoStart(context, true); //配置是否开启自启动
        if(!BuildConfig.DEBUG){
            XGPushConfig.enableDebug(context, false);
        }
    }

    /**
     * 客製訊息內容
     * @param context
     */
    public void initCustomPushNotificationBuilder(Context context){
        XGCustomPushNotificationBuilder build = new XGCustomPushNotificationBuilder();
        build.setIcon(R.mipmap.ic_launcher_round);
        //build.setNotificationLargeIcon(R.mipmap.ic_launcher_round);
        build.setSmallIcon(R.drawable.notification_icon);
        build.setDefaults(Notification.DEFAULT_VIBRATE);
        //build.setLedARGB(Color.argb(255,69,192,26));
        XGPushManager.setPushNotificationBuilder(context, 1, build);
    }

    /**
     * 判斷是否第一次安裝執行
     * @return
     */
    private void isFirstLaunch(){
        try {
            Log.d(TAG,"isFirstLaunch");
            SharedPreferences sharedPreferences = this.activity.getSharedPreferences(BuildConfig.APPLICATION_ID, this.activity.MODE_PRIVATE);
            boolean isFirstRun = sharedPreferences.getBoolean("isFirstRun", true);
            Log.d(TAG,"isFirstLaunch:"+isFirstRun);
            if (isFirstRun) {
                FlutterNotificationPlugin.newRelicNotification("isFirstRun");
                sharedPreferences.edit().putBoolean("isFirstRun",false).commit();
                try {
                    JSONObject object = new JSONObject();
                    object.put("type", "agreeNotification");
                    new ShowAlertDialogAsyncTask().execute(object.toString());
                }catch (Exception error){
                    Log.e(TAG,error.getMessage());
                }


            }
        } catch (Exception Err){
            MainActivity.newRelicErr("isFirstLaunch" + Err.getMessage());
            Log.e(TAG,Err.getMessage());
        }
    }

    /**
     * 取得是否接收到訊息通知
     */
    private void getNotificationPermission(){
        try {
            if(XGPushManager.isNotificationOpened(context)) {
                this.result.success("agree");
            }else{
                this.result.success("none");
            }
        }catch (Exception error){
            Log.e(TAG, error.getMessage());
            this.result.error("Error",error.getMessage(),null);
        }
    }

    public static void newRelicNotification(String message) {
        try {
            Map attributes = new HashMap();
            attributes.put("Messages", message);
            attributes.put("appProjectName", "MobilePossApp");
            NewRelic.recordCustomEvent("FTNotification", attributes);
        } catch (Exception e) {
            e.printStackTrace();
            NewRelic.recordHandledException(e);
        }
    }

}
