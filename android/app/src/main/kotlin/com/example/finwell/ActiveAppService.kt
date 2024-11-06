package com.example.finwell

import android.app.*
import android.app.usage.UsageEvents
import android.app.usage.UsageStats
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.PixelFormat
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.net.Uri
import android.os.Build
import android.os.CountDownTimer
import android.os.Handler
import android.os.IBinder
import android.util.Log
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.TextView
import android.widget.Toast
import androidx.core.app.NotificationCompat

import java.util.*

class ActiveAppService: Service() {




    private var iconNotification: Bitmap? = null
    private var notification: Notification? = null
    var mNotificationManager: NotificationManager? = null

    // var window:AppRestrictWindow? = null
    var previousApp = ""
    var currentApp = ""
    var sessionStartTime = ""
    var appSession = 0
    var paymentApps: List<String> = listOf<String>()


    private val mNotificationId = 123
    var overlayView:View? = null

    val TAG = "RaviForeground"
    private val builder = NotificationCompat.Builder(this, "service_channel")

    // BuildForeGroundTaskNotification is responsible to build notification every time the foreground app change

    private fun getPaymentPackages(): List<String> {
        val paymentApps = mutableListOf<String>()
        val packageManager = packageManager


        val intent = Intent(Intent.ACTION_VIEW)
        intent.addCategory(Intent.CATEGORY_DEFAULT)
        intent.data = Uri.parse("upi://pay")

        val resolveInfos = packageManager.queryIntentActivities(intent, PackageManager.MATCH_DEFAULT_ONLY)
        for (resolveInfo in resolveInfos) {
            val packageName = resolveInfo.activityInfo.packageName
            paymentApps.add(packageName)
        }

        return paymentApps
    }

    private fun buildForegroundTaskNotification() {
        paymentApps = getPaymentPackages();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            previousApp = currentApp
            currentApp = getTopPkgName(this)

        } else {
            val am = this.getSystemService(ACTIVITY_SERVICE) as ActivityManager
            val tasks = am.runningAppProcesses
            Log.e("Running Task", "${tasks.size}")
            previousApp = currentApp
            currentApp = tasks[0].processName

        }
        val packageManager: PackageManager = applicationContext.packageManager
        val appName = packageManager.getApplicationLabel(packageManager.getApplicationInfo(currentApp, PackageManager.GET_META_DATA)) as String
//        Log.e(TAG, "Current App in foreground is: $currentApp")
//        Log.e(TAG, "Current AppNam in foreground is: $appName")
        val intentMainLanding = Intent(this, MainActivity::class.java)
        val pendingIntent =
                PendingIntent.getActivity(this, 0, intentMainLanding, PendingIntent.FLAG_IMMUTABLE)
        val mNotificationManager = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
        try {


            if (previousApp != currentApp) {

            }

            builder.setContentTitle(
                    StringBuilder("No spend Mode active").toString()
            )
                    .setContentText("All payment apps are disable")
                    .setPriority(NotificationCompat.PRIORITY_LOW)
                    .setWhen(0)
                    .setOnlyAlertOnce(true)
                    .setSmallIcon(R.mipmap.ic_launcher)
                    .setContentIntent(pendingIntent)
                    .setOngoing(true)


            //

//            builder.color =
            notification = builder.build()
            //DatabaseHandler.instance.getAllApps()
            if (Helper.isAppRunning(this, currentApp)) {
                Log.e("App Is Running", currentApp)
            } else {
                Log.e("service is running For", currentApp)
            }


            val activeApp = getTopPkgName(this);
            Log.e("Current Active App", "$currentApp")
            Log.e("fromTopPkg", "$activeApp")


//
            if (paymentApps.contains(currentApp)){
                closeRestrictedApp()
            }
            else{
                removeOverlay()
            }

            mNotificationManager.notify(mNotificationId, notification);

        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }


    }


    fun getForegroundApplication(context: Context) {
        try {
            buildForegroundTaskNotification()

        } catch (e: Exception) {

            e.printStackTrace()
        }
    }


    override fun onBind(intent: Intent?): IBinder? {
        while (true) {
            Handler().postDelayed({
                Log.d(TAG, "onBind: Running")
            }, 100)
        }
        return null
    }


    override fun onCreate() {
        super.onCreate()


    }

    private fun startContinue() {
        val timer = object : CountDownTimer(Long.MAX_VALUE, 1000) {
            override fun onTick(millisUntilFinished: Long) {
                getForegroundApplication(this@ActiveAppService)
            }

            override fun onFinish() {
                Log.d(TAG, "onFinish: called")
            }
        }

        timer.start()
    }


    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("Ravi", "onStartCommand: Started")
        generateForegroundNotification()

        return super.onStartCommand(intent, flags, startId)
    }

//    fun closeFocusModeApp(){
//        val startMain = Intent(Intent.ACTION_MAIN)
//        startMain.addCategory(Intent.CATEGORY_HOME)
//        startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
//        Toast.makeText(this, "Daily Usage Reached", Toast.LENGTH_SHORT).show()
//        this.startActivity(startMain)
//    }

    fun closeRestrictedApp() {
if(overlayView == null){
    showOverlay()
}
//        window?.open()




    }



    private fun openApp() {
        try {
            val openAppIntent = Intent(this, MainActivity::class.java).apply {
                addFlags(Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP)
            }
            startActivity(openAppIntent)
        }
        catch (e:Exception){
            Log.e("Navigation Exception", e.toString())
        }
    }

    private fun goToHomeScreen() {
        val intent = Intent(Intent.ACTION_MAIN)
        intent.addCategory(Intent.CATEGORY_HOME)
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        startActivity(intent)
    }


    private fun generateForegroundNotification() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val intentMainLanding = Intent(this, MainActivity::class.java)
            val pendingIntent =
                    PendingIntent.getActivity(this, 0, intentMainLanding, PendingIntent.FLAG_IMMUTABLE)
            iconNotification = BitmapFactory.decodeResource(resources, R.mipmap.ic_launcher)
            if (mNotificationManager == null) {
                mNotificationManager =
                        this.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                assert(mNotificationManager != null)
                mNotificationManager?.createNotificationChannelGroup(
                        NotificationChannelGroup("chats_group", "Chats")
                )
                val notificationChannel =
                        NotificationChannel(
                                "service_channel", "Service Notifications",
                                NotificationManager.IMPORTANCE_MIN
                        )
                notificationChannel.enableLights(false)
                notificationChannel.lockscreenVisibility = Notification.VISIBILITY_SECRET
                mNotificationManager?.createNotificationChannel(notificationChannel)
            }


            builder.setContentTitle(
                    StringBuilder("Testing").append(" service is running")
                            .toString()
            )
                    .setTicker(
                            StringBuilder("Testing").append("service is running")
                                    .toString()
                    )
                    .setContentText("${currentApp}") //                    , swipe down for more options.

                    .setPriority(NotificationCompat.PRIORITY_LOW)
                    .setWhen(0)
                    .setOnlyAlertOnce(true)
                    .setSmallIcon(R.drawable.launch_background)

                    .setOngoing(true)

//            if (iconNotification != null) {
//                builder.setLargeIcon(Bitmap.createScaledBitmap(iconNotification!!, 128, 128, false))
//            }
//            builder.color =
            notification = builder.build()

            startForeground(mNotificationId, notification)
            startContinue()

        }


    }

    object Helper {
        fun isAppRunning(context: Context, packageName: String?): Boolean {
            val activityManager = context.getSystemService(ACTIVITY_SERVICE) as ActivityManager
            val procInfos = activityManager.runningAppProcesses
            if (procInfos != null) {
                for (processInfo in procInfos) {
                    if (processInfo.processName.equals(packageName)) {
                        return true
                    }
                }
            }
            return false
        }
    }

    fun convertSeconds(seconds: Int): String? {
        val h = seconds / 3600
        val m = seconds % 3600 / 60
        val s = seconds % 60
        val sh = if (h > 0) "$h h" else ""
        val sm = (if (m < 10 && (m > 0) && h > 0) "0" else "") + if (m > 0) (if (h > 0 && s == 0) m.toString() else "$m min") else ""
        val ss = if (s == 0 && (h > 0 || m > 0)) "" else (if (s < 10 && (h > 0 || m > 0)) "0" else "") + s.toString() + " " + "sec"
        return sh + (if (h > 0) " " else "") + sm + (if (m > 0) " " else "") + ss
    }

    fun getTopPkgName(context: Context): String {
        var pkgName: String? = null
        val usageStatsManager = context
                .getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
        val timeTnterval = (1000 * 600).toLong()
        val endTime = System.currentTimeMillis()
        val beginTime = endTime - timeTnterval
        val myUsageEvents: UsageEvents = usageStatsManager.queryEvents(beginTime, endTime)
        while (myUsageEvents.hasNextEvent()) {
            val myEvent: UsageEvents.Event = UsageEvents.Event()
            myUsageEvents.getNextEvent(myEvent)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                when (myEvent.eventType) {
                    UsageEvents.Event.ACTIVITY_RESUMED -> pkgName = myEvent.packageName
                    UsageEvents.Event.ACTIVITY_PAUSED -> if (myEvent.packageName.equals(pkgName)) {
                        pkgName = null
                    }
                }
            } else {
                when (myEvent.eventType) {
                    UsageEvents.Event.ACTIVITY_RESUMED -> pkgName = myEvent.packageName
                    UsageEvents.Event.ACTIVITY_RESUMED -> if (myEvent.packageName.equals(pkgName)) {
                        pkgName = null
                    }
                }
            }
        }
        if (pkgName == null) {
            var currentApp = ""
            val usm = this.getSystemService(USAGE_STATS_SERVICE) as UsageStatsManager
            val time = System.currentTimeMillis()
            val appList =
                    usm.queryUsageStats(UsageStatsManager.INTERVAL_DAILY, time - 1000 * 1000, time)
            if (appList != null && appList.size > 0) {
                val mySortedMap: SortedMap<Long, UsageStats> = TreeMap()
                for (usageStats in appList) {
                    mySortedMap[usageStats.lastTimeUsed] = usageStats
                }
                if (mySortedMap != null && !mySortedMap.isEmpty()) {
                    currentApp = mySortedMap[mySortedMap.lastKey()]!!.packageName
                }
            }
            return currentApp
        } else {
            return pkgName
        }

    }

    private fun showOverlay() {
        val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager

        val layoutParams = WindowManager.LayoutParams(
                WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY,  // For Android Oreo and above
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE,
                PixelFormat.TRANSLUCENT
        )

        layoutParams.gravity = Gravity.CENTER
        overlayView = LayoutInflater.from(this).inflate(R.layout.overlay_layout, null)
        windowManager.addView(overlayView, layoutParams)

        // Example: You can manipulate the view like updating text dynamically
        val textView: TextView = overlayView!!.findViewById(R.id.overlay_text)
        textView.text = "No Spend Mode Active"
    }
    fun removeOverlay(){
        if(overlayView != null){
            val windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
            windowManager.removeViewImmediate(overlayView)
            overlayView = null
        }

    }


}

