package com.example.finwell

import android.Manifest
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.os.Bundle
import android.telephony.SmsMessage
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat.getSystemService


class SmsReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action.equals("android.provider.Telephony.SMS_RECEIVED")) {
            val bundle: Bundle? = intent.extras
            try {
                if (bundle != null) {
                    val pdusObj = bundle.get("pdus") as Array<Any>
                    for (pdu in pdusObj) {
                        val currentMessage = SmsMessage.createFromPdu(pdu as ByteArray)
                        val phoneNumber = currentMessage.displayOriginatingAddress
                        val message = currentMessage.displayMessageBody

                        Log.d("SmsReceiver", "Phone Number: $phoneNumber; Message: $message")

                        // Show notification
                        showNotification(context, phoneNumber, message)
                    }
                }
            } catch (e: Exception) {
                Log.e("SmsReceiver", "Exception: ${e.message}")
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun showNotification(context: Context, phoneNumber: String, message: String) {
        val channelId = "finwell"
        val notificationId = System.currentTimeMillis().toInt()

        val channel = NotificationChannel(
                "finwell",
                "Finwell Notifications",
                NotificationManager.IMPORTANCE_DEFAULT
        )


        val notificationBuilder = NotificationCompat.Builder(context, channelId)
                .setSmallIcon(android.R.drawable.ic_menu_view)
                .setContentTitle("New SMS from $phoneNumber")
                .setContentText(message)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setAutoCancel(true)

        val notificationManager = NotificationManagerCompat.from(context)
        notificationManager.createNotificationChannel(channel)
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return
        }
        notificationManager.notify(notificationId, notificationBuilder.build())
    }


}
