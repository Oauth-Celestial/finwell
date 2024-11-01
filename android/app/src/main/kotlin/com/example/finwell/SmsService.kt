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
import kotlin.random.Random


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

                            var isTransactionMessage = classifyMessage(message)

                            if(isTransactionMessage){
                                val amount = getAmount(message)
                                val transactionType = message.lowercase().contains("debited")

                                    message = if(transactionType){
                                        // Output: Amount: 150.0
                                        "You have Spend - ₹${amount} "
                                    } else{
                                        "You Have received + ₹${amount}  "
                                    }


                                    showNotification(context,amount.toString(),message,transactionType)


                            }


                        }
                    }
                }
            } catch (e: Exception) {
                Log.e("SmsReceiver", "Exception: ${e.message}")
            }
        }
    }


    private fun getAmount(text:String): String {


        // Define the regex pattern
        val pattern = Regex("""Rs\.\s*(\d+\.\d{2}|\d+)""")

        // Find the match
        val matchResult = pattern.find(text)

        // Extract and print the amount if found
        if (matchResult != null) {
            return matchResult.groupValues[1]
        } else {
          return  ""
        }
    }

    private fun classifyMessage(message: String): Boolean {
        // Define a regex pattern to match transaction messages
        val pattern = Regex("""(?i)\b(debited|credited|amount|transaction|upi)\b""")
        return pattern.containsMatchIn(message)
    }


    @RequiresApi(Build.VERSION_CODES.O)
    private fun showNotification(context: Context, amount: String, message: String, debited: Boolean, ) {

        try {
            if (amount.isEmpty()) return
            DatabaseHelper.instance.insertTransaction(amount,debited)
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

        if(amount.isEmpty()){
            val notificationBuilder = NotificationCompat.Builder(context, channelId)
                    .setSmallIcon(android.R.drawable.ic_menu_view)
                    .setContentTitle("A Transaction took place")
                    .setContentText(getNotificationTitle())
                    .setPriority(NotificationCompat.PRIORITY_HIGH)
                    .setAutoCancel(true)

            val notificationManager = NotificationManagerCompat.from(context)
            notificationManager.createNotificationChannel(channel)
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {

                return
            }
            notificationManager.notify(notificationId, notificationBuilder.build())

        }
        else{
            val notificationBuilder = NotificationCompat.Builder(context, channelId)
                    .setSmallIcon(android.R.drawable.ic_menu_view)
                    .setContentTitle("Tell us where you $spent")
                    .setContentText(message)
                    .setPriority(NotificationCompat.PRIORITY_HIGH)
                    .setAutoCancel(true)

            val notificationManager = NotificationManagerCompat.from(context)
            notificationManager.createNotificationChannel(channel)
            if (ActivityCompat.checkSelfPermission(context, Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {

                return
            }
            notificationManager.notify(notificationId, notificationBuilder.build())
        }
        }



    fun getNotificationTitle(): String {
        // List of funny transaction messages
        val notifications = listOf(
                "Looks like you've been busy making money moves! 💸",
                "Ah, I see your wallet is getting some exercise! 🏋️‍♂️",
                "Well, well, someone's been making it rain! ☔️",
                "I see you've taken a little trip to the transaction side! 🚀",
                "Your bank account just did a happy dance! 💃🕺",
                "Looks like you’ve been shopping like a pro! 🛒💳",
                "I see you've got some new numbers to brag about! 📈",
                "Looks like you've been making those digits work overtime! 🔢💼"
        )

        // Pick a random notification
        val randomNotification = notifications[Random.nextInt(notifications.size)]

        // Print the random notification
      return  randomNotification
    }


}
