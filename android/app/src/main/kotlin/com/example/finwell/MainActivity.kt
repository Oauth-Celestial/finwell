package com.example.finwell

import android.app.ActivityManager
import android.app.AppOpsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.util.Log
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.provider.Settings

class MainActivity: FlutterActivity() {
    var methodChannelName: String = "timeTracker";

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, methodChannelName).setMethodCallHandler { call, result ->
            if (call.method == "startForeGround") {
               // val hashMap = call.arguments as HashMap<*, *> //Get the arguments as a HashMap

//                val dbPath = hashMap["dbPath"]
//                Log.e("DbPath","$dbPath")//Get the argument based on the key passed from Flutter

//                DatabaseHandler.instance.clearTableData("DailyUsage")


                val i = Intent(context, ActiveAppService::class.java)

                val isAlreadyRunning: Boolean = context.isMyServiceRunning(ActiveAppService::class.java)

                if (!isAlreadyRunning) {
                    context.startService(i)
                    Log.e("Service Status", "Started New Service")

                } else {
                    Log.e("Service Status", "Already Running")
                }


            }

            else if (call.method == "hasUsageStatsPermission"){
                result.success(hasUsageStatsPermission())
            }

            else if(call.method == "requestUsageStatsPermission"){
                requestUsageStatsPermission()
                result.success(null)
            }

            else if(call.method == "getPaymentApps"){
                result.success(getPaymentApps())
            }

            else if(call.method == "isServiceRunning"){
                val isAlreadyRunning: Boolean = context.isMyServiceRunning(ActiveAppService::class.java)
            result.success(isAlreadyRunning)
            }

            else if (call.method == "stopForegroundService"){
                stopForegroundService()
                result.success(null)
            }

            else if(call.method == "askDrawPermission"){
                requestOvelayPermission()
            }

        }
    }

    fun requestOvelayPermission(){
        if (!Settings.canDrawOverlays(this)) {
            val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION)
            startActivity(intent)
        }
    }

    private fun hasUsageStatsPermission(): Boolean {
        val appOpsManager = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOpsManager.checkOpNoThrow(
                AppOpsManager.OPSTR_GET_USAGE_STATS,
                android.os.Process.myUid(),
                packageName
        )
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun requestUsageStatsPermission() {
        val intent = Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS)
        startActivity(intent)
    }


    fun Context.isMyServiceRunning(serviceClass: Class<*>): Boolean {
        val manager = this.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        return manager.getRunningServices(Integer.MAX_VALUE)
                .any { it.service.className == serviceClass.name }
    }

    private fun stopForegroundService() {
        val serviceIntent = Intent(this, ActiveAppService::class.java)
        stopService(serviceIntent) // Stop the service
    }


    private fun getPaymentApps(): List<String> {
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
}