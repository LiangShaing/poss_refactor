package com.example.poss_mobile_app.plugin;

import android.app.Activity;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import com.newrelic.agent.android.NewRelic;
import com.newrelic.agent.android.util.NetworkFailure;

import org.jetbrains.annotations.NotNull;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/** FlutterNewRelicPlugin */
public class FlutterNewRelicPlugin implements FlutterPlugin,
        MethodCallHandler,
        ActivityAware {
  private MethodChannel channel;
  private static MethodChannel.Result result;
  private static boolean startFlag = false;
  private Activity activity;
  private static String appProjectName = "MobilePossApp";

  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    flutterEngine.getPlugins().add(new FlutterNewRelicPlugin());
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    FlutterNewRelicPlugin.startFlag = true;
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "flutter_new_relic");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if(call.arguments == null){
      result.error("Error","arg empty",null);
    }
    FlutterNewRelicPlugin.result = result;
    switch (call.method){
      case "incrementAttribute":
        this.incrementAttribute(call.arguments);
        break;
      case "setUserId":
        this.recordCustomEventByUserId(call.arguments);
        break;
      case "setInteraction":
        this.recordCustomEventByInteraction(call.arguments);
        break;
      case "recordCustomEventByJson":
        this.recordCustomEventByJson(call.arguments);
        break;
      case "recordCustomEventByMessage":
        this.recordCustomEventByMessage(call.arguments);
        break;
      case "recordCustomEventByError":
        this.recordCustomEventByError(call.arguments);
        break;
      case "noticeHttpTransaction":
        this.noticeHttpTransaction(call.arguments);
        break;
      case "noticeNetworkFailure":
        this.noticeNetworkFailure(call.arguments);
        break;
        default:
        result.error("Error", "call method error", null);
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
    //FlutterNewRelicPlugin.startFlag = false;
  }

  //追蹤發生次數
  private void incrementAttribute(Object arguments){
    Map<String, Object> args = (Map<String, Object>) arguments;
    if(!args.containsKey("name") || args.get("name") == null){
      FlutterNewRelicPlugin.result.error("Error","args name error",null);
    }else if(!args.containsKey("value") || args.get("value") == null){
      FlutterNewRelicPlugin.result.error("Error","args value error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }

    try {
      String name = (String) args.get("name");
      double value = (int) args.get("value");
      Boolean status = NewRelic.incrementAttribute(name, value);
      if (!status) {
        FlutterNewRelicPlugin.result.error("NewRelicError", "send fail", null);
      }
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //紀錄userId
  private void recordCustomEventByUserId(Object arguments) {
    Map<String,String> args = (Map<String, String>) arguments;
    if(!args.containsKey("userId") || args.get("userId").isEmpty()){
      FlutterNewRelicPlugin.result.error("Error","args userId error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }
    try {
      Map attributes = new HashMap();
      attributes.put("UserId", args.get("userId"));
      attributes.put("appProjectName", appProjectName);
      Boolean status = NewRelic.recordCustomEvent("FTUserId", attributes);
      if(!status) {
        FlutterNewRelicPlugin.result.error("NewRelicError","send fail",null);
      }
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //紀錄頁面名稱
  private void recordCustomEventByInteraction(Object arguments) {
    Map<String,String> args = (Map<String, String>) arguments;
    if(!args.containsKey("screen") || args.get("screen").isEmpty()){
      FlutterNewRelicPlugin.result.error("Error","args screen error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }
    try {
      Map attributes = new HashMap();
      attributes.put("Screen", args.get("screen"));
      attributes.put("appProjectName", appProjectName);
      Boolean status = NewRelic.recordCustomEvent("FTInteraction", attributes);
      if(!status) {
        FlutterNewRelicPlugin.result.error("NewRelicError","send fail",null);
      }
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //自訂義事件名稱與內容 by json
  private void recordCustomEventByJson(Object arguments) {
    Map<String,Object> args = (Map<String, Object>) arguments;
    if(!args.containsKey("eventName") || args.get("eventName") == null){
      FlutterNewRelicPlugin.result.error("Error","args eventName error",null);
    }else if(!args.containsKey("jsonString") || args.get("jsonString") == null){
      FlutterNewRelicPlugin.result.error("Error","args jsonString error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }
    try {
      String eventName = (String) args.get("eventName");
      String jsonString = (String) args.get("jsonString");
      JSONObject obj = new JSONObject(jsonString);
      Map attributes = new HashMap();
      Iterator<String> keys = obj.keys();
      while (keys.hasNext()) {
        String key = keys.next();
        attributes.put(key, obj.get(key).toString());
      }
      attributes.put("appProjectName",appProjectName);
      Boolean status = NewRelic.recordCustomEvent(eventName, attributes);
      if(!status) {
        FlutterNewRelicPlugin.result.error("NewRelicError","send fail",null);
      }
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //自訂義事件名稱與內容 by Message
  private void recordCustomEventByMessage(Object arguments) {
    Map<String,Object> args = (Map<String, Object>) arguments;
    if(!args.containsKey("eventName") || args.get("eventName") == null){
      FlutterNewRelicPlugin.result.error("Error","args eventName error",null);
    }else if(!args.containsKey("message") || args.get("message") == null){
      FlutterNewRelicPlugin.result.error("Error","args message error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }
    try {
      String eventName = (String) args.get("eventName");
      Map attributes = new HashMap();
      attributes.put("Messages", args.get("message"));
      attributes.put("appProjectName",appProjectName);
      Boolean status = NewRelic.recordCustomEvent(eventName, attributes);
      if(!status) {
        FlutterNewRelicPlugin.result.error("NewRelicError","send fail",null);
      }
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //錯誤訊息
  private void recordCustomEventByError(Object arguments) {
    Map<String,String> args = (Map<String, String>) arguments;
    if(!args.containsKey("errorMessage") || args.get("errorMessage").isEmpty()){
      FlutterNewRelicPlugin.result.error("Error","args userId error",null);
    }
    try {
      Map attributes = new HashMap();
      attributes.put("errorMessage", args.get("errorMessage"));
      attributes.put("appProjectName",appProjectName);
      Boolean status = NewRelic.recordCustomEvent("FTError", attributes);
      if(!status) {
        FlutterNewRelicPlugin.result.error("NewRelicError","send fail",null);
      }else if(FlutterNewRelicPlugin.startFlag == false){
        FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
      }
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //Http Transaction
  private void noticeHttpTransaction(Object arguments) {
    Map<String,Object> args = (Map<String, Object>) arguments;
    if(!args.containsKey("url") || args.get("url") == null){
      FlutterNewRelicPlugin.result.error("Error","args url error",null);
    }else if(!args.containsKey("httpMethod") || args.get("httpMethod") == null){
      FlutterNewRelicPlugin.result.error("Error","args httpMethod error",null);
    }else if(!args.containsKey("statusCode") || args.get("statusCode") == null){
      FlutterNewRelicPlugin.result.error("Error","args statusCode error",null);
    }else if(!args.containsKey("startTime") || args.get("startTime") == null){
      FlutterNewRelicPlugin.result.error("Error","args startTime error",null);
    }else if(!args.containsKey("endTime") || args.get("endTime") == null){
      FlutterNewRelicPlugin.result.error("Error","args endTime error",null);
    }else if(!args.containsKey("requestSize") || args.get("requestSize") == null){
      FlutterNewRelicPlugin.result.error("Error","args requestSize error",null);
    }else if(!args.containsKey("responseSize") || args.get("responseSize") == null){
      FlutterNewRelicPlugin.result.error("Error","args responseSize error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }

    try {
      String url = (String) args.get("url");
      String httpMethod = (String) args.get("httpMethod");
      int statusCode = (int) args.get("statusCode");
      long startTime = Long.parseLong(args.get("startTime").toString());
      long endTime = Long.parseLong(args.get("endTime").toString());
      long requestSize = Long.parseLong(args.get("requestSize").toString());
      long responseSize = Long.parseLong(args.get("responseSize").toString());
      NewRelic.noticeHttpTransaction(url, httpMethod, statusCode, startTime, endTime, requestSize, responseSize);
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  //Http NetworkFailure
  private void noticeNetworkFailure(Object arguments) {
    Map<String,Object> args = (Map<String, Object>) arguments;
    if(!args.containsKey("url") || args.get("url") == null){
      FlutterNewRelicPlugin.result.error("Error","args url error",null);
    }else if(!args.containsKey("httpMethod") || args.get("httpMethod") == null){
      FlutterNewRelicPlugin.result.error("Error","args httpMethod error",null);
    }else if(!args.containsKey("statusCode") || args.get("statusCode") == null){
      FlutterNewRelicPlugin.result.error("Error","args statusCode error",null);
    }else if(!args.containsKey("startTime") || args.get("startTime") == null){
      FlutterNewRelicPlugin.result.error("Error","args startTime error",null);
    }else if(!args.containsKey("endTime") || args.get("endTime") == null){
      FlutterNewRelicPlugin.result.error("Error","args endTime error",null);
    }else if(FlutterNewRelicPlugin.startFlag == false){
      FlutterNewRelicPlugin.result.error("Error","newrelic not start",null);
    }

    try {
      String url = (String) args.get("url");
      String httpMethod = (String) args.get("httpMethod");
      int statusCode = (int) args.get("statusCode");
      long startTime = Long.parseLong(args.get("startTime").toString());
      long endTime = Long.parseLong(args.get("endTime").toString());
      NetworkFailure networkFailure;
      switch (statusCode){
        case 400:
          networkFailure = NetworkFailure.fromErrorCode(NetworkFailure.BadServerResponse.getErrorCode());
          break;
        default:
          networkFailure = NetworkFailure.fromErrorCode(NetworkFailure.Unknown.getErrorCode());
          break;
      }
      NewRelic.noticeNetworkFailure(url, httpMethod, startTime, endTime , networkFailure, String.valueOf(statusCode));
    }catch (Exception ex) {
      FlutterNewRelicPlugin.result.error("Exception", ex.getMessage(), null);
    }
  }

  @Override
  public void onAttachedToActivity(@NonNull @NotNull ActivityPluginBinding binding) { activity = binding.getActivity(); }

  @Override
  public void onDetachedFromActivityForConfigChanges() { activity = null; }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull @NotNull ActivityPluginBinding binding) { activity = binding.getActivity(); }

  @Override
  public void onDetachedFromActivity() {
    activity = null;
  }
}
