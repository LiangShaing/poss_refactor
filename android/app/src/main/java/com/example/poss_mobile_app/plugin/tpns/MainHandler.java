package com.example.poss_mobile_app.plugin.tpns;

import android.os.Handler;
import android.os.Looper;

public class MainHandler extends Handler {
    private static  MainHandler instance;

    public static MainHandler getInstance() {
        if(null == instance){
            instance = new MainHandler();
        }
        return instance;
    }

    private MainHandler(){
        super(Looper.getMainLooper());
    }
}
