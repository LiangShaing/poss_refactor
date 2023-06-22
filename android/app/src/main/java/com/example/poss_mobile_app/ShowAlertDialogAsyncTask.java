package com.example.poss_mobile_app;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.AsyncTask;
import org.json.JSONObject;
import io.flutter.Log;

//非同步顯示alert視窗
public class ShowAlertDialogAsyncTask extends AsyncTask<String, Integer, Integer> {
    private String TAG = "ShowAlertDialogAsyncTask";
    private String param="";

    @Override
    protected Integer doInBackground(String... param) {
        Log.d(TAG,"doInBackground");
        if(param.length > 0){
            this.param = param[0]; //json String
        }
        return null;
    }

    @Override
    protected void onPostExecute(Integer result) {
        super.onPostExecute(result);
        Log.d(TAG,"onPostExecute param:" + this.param);
        try {
            if(this.param.isEmpty()){
                return;
            }
            JSONObject obj = new JSONObject(this.param);
            String type = obj.get("type").toString();
            Log.d(TAG,"onPostExecute type:" + type);
            switch (type){
                case "check_version":
                    String downloadUrl = obj.get("downloadUrl").toString();
                    if(downloadUrl.isEmpty()){
                        Log.w(TAG,"onPostExecute downloadUrl empty");
                        return;
                    }
                    checkAlertDialog(downloadUrl);
                    break;
                case "agreeNotification":
                    showAgreeNotificationDialog();
                    break;
            }
        }catch (Exception error){
            Log.e(TAG,error.getMessage());
            MainActivity.newRelicErr("onPostExecuteError:"+error.getMessage());
        }
    }

    @Override
    protected void onProgressUpdate(Integer... values) {
        super.onProgressUpdate(values);
    }

    @Override
    protected void onPreExecute() {
        super.onPreExecute();
    }

    /**
     * 版本確認視窗
     * @param downloadUrl
     */
    private void  checkAlertDialog (String downloadUrl){
        try {
            Log.d(TAG,"checkAlertDialog");
            String message = Language.getLanguageString("check_version");
            AlertDialog.Builder alertDialog = new AlertDialog.Builder(MainActivity.getContext());
            alertDialog.setTitle(null);
            alertDialog.setMessage(message);
            alertDialog.setNegativeButton("Cancel",(dialog, which) -> {
            });
            alertDialog.setPositiveButton("OK", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    try {
                        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(downloadUrl));
                        MainActivity.getContext().startActivity(intent);
                    } catch (Exception Err){
                        MainActivity.newRelicErr("checkAlertDialogError " + Err.getMessage());
                        Log.e(TAG,Err.getMessage());
                    }
                }
            });
            alertDialog.setCancelable(false);
            alertDialog.show();
        } catch (Exception Err){
            MainActivity.newRelicErr("checkAlertDialogError" + Err.getMessage());
            Log.e(TAG,Err.getMessage());
        }
    }

    /**
     * 顯示同意接收訊息通知
     */
    private void showAgreeNotificationDialog(){
        try {
            Log.d(TAG,"showAgreeNotificationDialog");
            AlertDialog.Builder alertDialog = new AlertDialog.Builder(MainActivity.getContext());
            alertDialog.setTitle(null);
            alertDialog.setMessage(Language.getLanguageString("apply_notification"));
            alertDialog.setNegativeButton(Language.getLanguageString("disagree"), new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    Intent intent = new Intent();
                    intent.setAction("android.settings.APP_NOTIFICATION_SETTINGS");
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    intent.putExtra("app_package", MainActivity.getContext().getPackageName());
                    intent.putExtra("app_uid", MainActivity.getContext().getApplicationInfo().uid);
                    intent.putExtra("android.provider.extra.APP_PACKAGE", MainActivity.getContext().getPackageName());
                    MainActivity.getContext().startActivity(intent);
                    dialog.dismiss();
                }
            });
            alertDialog.setPositiveButton(Language.getLanguageString("agree"),(dialog, which) -> {
            });
            alertDialog.setCancelable(false);
            alertDialog.create().show();
        } catch (Exception Err){
            MainActivity.newRelicErr("showAgreeNotificationDialogError" + Err.getMessage());
            Log.e(TAG,Err.getMessage());
        }
    }
}
