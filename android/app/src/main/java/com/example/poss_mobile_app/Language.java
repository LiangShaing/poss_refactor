package com.example.poss_mobile_app;

import com.newrelic.agent.android.NewRelic;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import io.flutter.Log;

public class Language {
    private static String TAG = "Language";

    static String lan;
    static Map<String, Map<String,String>> lanMap;

    public static void initLanguage(){
        Log.d(TAG,"initLanguage");
        initString();
        String _lan = Locale.getDefault().getLanguage();
        String _script = "";
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
            _script = Locale.getDefault().getScript();
        }
        String locale="";
        String _country = Locale.getDefault().getCountry();
        if(_script.isEmpty()){
            locale = _lan + "_" + _country;
        }else{
            locale = _lan + "_" + _script + "_" + _country;
        }
        Log.d(TAG,"locale:" + locale);

        if(locale.contains("zh_Hans") == true ||
                locale.contains("wuu_Hans") == true ||
                locale.contains("yue_Hans") == true ||
                locale.contains("zh_CN") == true){
            lan = "zh-CN";
        }else{
            lan = "zh-TW";
        }
    }

    public static String getLanguageString(String key){
        if(null == lan){
            Log.w(TAG,"getLanguageString lan null");
            return null;
        }
        try {
            return lanMap.get(lan).get(key);
        }catch (Exception error){
            Log.e(TAG, error.getMessage());
            newRelicErr(error.getMessage());
        }
        return "";
    }

    private static void initString(){
        Log.d(TAG,"initString");
        lanMap = new HashMap();
        Map<String,String> _zh_cn = new HashMap();
        Map<String,String> _zh_tw = new HashMap();

        _zh_cn.put("check_version","新版本已发布请下载更新");
        _zh_cn.put("apply_notification","是否同意接顯示通知訊息?");
        _zh_cn.put("agree","同意");
        _zh_cn.put("disagree","不同意");

        _zh_tw.put("check_version","新版本已發布請下載更新");
        _zh_tw.put("apply_notification","是否同意接顯示通知讯息?");
        _zh_tw.put("agree","同意");
        _zh_tw.put("disagree","不同意");

        lanMap.put("zh-CN",_zh_cn);
        lanMap.put("zh-TW",_zh_tw);
    }

    static void newRelicErr(String errorMessage) {
        try {
            Map attributes = new HashMap();
            attributes.put("errorMessage", String.format("%s:%s",TAG,errorMessage));
            attributes.put("appProjectName", "MobilePossApp");
            NewRelic.recordCustomEvent("FTError", attributes);
        } catch (Exception e) {
            e.printStackTrace();
            NewRelic.recordHandledException(e);
        }
    }
}
