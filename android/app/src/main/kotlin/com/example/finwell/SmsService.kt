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
import java.util.regex.Pattern


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
                        var message = currentMessage.displayMessageBody

                        Log.d("SmsReceiver", "Phone Number: $phoneNumber; Message: $message")

                        // Show notification
                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {

                            var isTransactionMessage = classifyMessage(phoneNumber)

                            if(isTransactionMessage){
                                val (amount, type) = extractTransactionAmount(message)

                                if (amount != null && type != null) {
                                    println("Amount: $amount")
                                    message = if(type){
                                        // Output: Amount: 150.0
                                        "You have Spend - ₹${amount} "
                                    } else{
                                        "You Have received + ₹${amount}  "
                                    }
                                  showNotification(context,amount.toString(),message,type)
                                } else {
                                    println("No transaction found.")
                                }

                            }


                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("SmsReceiver", "Exception: ${e.message}")
            }
        }
    }

    private fun classifyMessage(message: String): Boolean {
        // Define a regex pattern to match transaction messages
        val regEx: Pattern = Pattern.compile("[a-zA-Z0-9]{2}-[a-zA-Z0-9]{6}")

        // Check if the message matches the transaction pattern
        val m = regEx.matcher(message)
        return m.find()
    }

    private fun extractTransactionAmount(message: String): Pair<Double?, Boolean?> {
        val regex = Regex("(credited|debited|received) \\$(\\d+(?:\\.\\d{1,2})?)")
        val matchResult = regex.find(message.lowercase())

        return if (matchResult != null) {
            val amount = matchResult.groupValues[2].toDoubleOrNull()
            val type = matchResult.groupValues[1]
            Pair(amount, type.lowercase() == "debited")
        } else {
            Pair(null, null) // No transaction found
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun showNotification(context: Context, amount: String, message: String, debited: Boolean) {

        try {
            DatabaseHelper.instance.insertMessage(message)
        }
        catch(e: Exception){
            Log.e("db ex", e.toString())
        }

        var transactionAmount :String = ""
        var transactionMessage = "";






        val channelId = "finwell"
        val notificationId = System.currentTimeMillis().toInt()

        val channel = NotificationChannel(
                "finwell",
                "Finwell Notifications",
                NotificationManager.IMPORTANCE_DEFAULT
        )


        val spent =  if (debited) "Spent" else "Received"



        val notificationBuilder = NotificationCompat.Builder(context, channelId)
                .setSmallIcon(android.R.drawable.ic_menu_view)
                .setContentTitle("Tell us where you $spent")
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
