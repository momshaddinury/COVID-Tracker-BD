package com.tne.selfreportingapp;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.media.RingtoneManager;
import android.net.Uri;
import android.os.Build;

import androidx.core.app.NotificationCompat;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;

public class FCMHandlerService extends FirebaseMessagingService {

    //private final String TAG = FCMHandlerService.class.getSimpleName();

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        // Check if message contains a data payload.
        if (remoteMessage.getData().size() > 0) {
            Map<String, String> map = remoteMessage.getData();

            //Get data payload
            //saveNotificationToLocal(map);

            String title = map.get("title");
            String msg = map.get("msg");
            sendNotification(title, msg);
        }

        // Check if message contains a notification payload.
        if (remoteMessage.getNotification() != null) {
            sendNotification(remoteMessage.getNotification().getTitle(), remoteMessage.getNotification().getBody());
        }
    }

//    @Override
//    public void onNewToken(String s) {
//        MySPHandler manager = new MySPHandler(getApplicationContext());
//        manager.setUserFCMToken(s);
//    }

    private void sendNotification(String title, String messageBody) {

        Intent intent = new Intent(this, MainActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        PendingIntent pendingIntent = PendingIntent.getActivity(this, 0, intent,
                PendingIntent.FLAG_ONE_SHOT);

        String channelId = "10";
        Uri defaultSoundUri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION);
        NotificationCompat.Builder notificationBuilder =
                new NotificationCompat.Builder(this, channelId)
                        .setSmallIcon(R.drawable.covid)
                        .setContentTitle(title)
                        .setContentText(messageBody)
                        .setAutoCancel(true)
                        .setSound(defaultSoundUri)
                        .setContentIntent(pendingIntent);

        NotificationManager notificationManager =
                (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

        if (notificationManager != null) {

            // Since android Oreo notification channel is needed.
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                NotificationChannel channel = new NotificationChannel(channelId,
                        "Notification from Admission assistant",
                        NotificationManager.IMPORTANCE_DEFAULT);
                notificationManager.createNotificationChannel(channel);
            }

            notificationManager.notify(0 /* ID of notification */, notificationBuilder.build());
        }
//        sendMessageToActivity();
    }

//    private void saveNotificationToLocal(Map<String, String> map) {
//        final NotificationDB db = NotificationDB.getInstance(getApplicationContext());
//        String title = map.get("title");
//        String msg = map.get("msg");
//        int maxID = db.notificationDAO().getMaxID();
//
//        if (maxID < 1){
//            maxID = 1;
//        }else {
//            maxID++;
//        }
//
//        String timestamp = map.get("timestamp");
//        String clickAction = "";
//        int clickFlag = 0;
//        if (map.containsKey("click_action")){
//            clickFlag = 1;
//            clickAction = map.get("click_action");
//        }
////        final NoticeModel model = new NoticeModel(Integer.parseInt(Objects.requireNonNull(map.get("id"))),
////                title, msg, timestamp, map.get("url"), Integer.parseInt(Objects.requireNonNull(map.get("v_id"))));
//
//        final NotificationModel notificationModel = new NotificationModel(maxID, title, msg, timestamp, clickAction, clickFlag);
//
//        new Thread(new Runnable() {
//            @Override
//            public void run() {
//                db.notificationDAO().insertNotification(notificationModel);
//            }
//        }).run();
//
//        sendNotification(title, msg);
//        //sendMessageToActivity();
//    }

    private void sendMessageToActivity() {
        Intent intent = new Intent("com.esp.cattronics.vaa.NotificationUpdates");
        intent.putExtra("msg", "new notification");
        LocalBroadcastManager.getInstance(this).sendBroadcast(intent);
    }
}
