package com.cubanopensource.todo

import android.content.*
import android.net.*
import android.os.*
import java.net.*
import java.util.*
import kotlin.collections.*
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.cubanopensource.todo"
    private lateinit var flEngine: FlutterEngine

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flEngine = flutterEngine

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getWifiIp" -> result.success(getWifiIP())
                "getInterfacesInfo" -> result.success(getInterfacesInfo())
                "getBatteryLevel" -> result.success(getBatteryLevel())
                "getAndroidName" -> result.success(getAndroidName())
                "callTo" -> result.success(callTo(call.arguments<String>()))
                "callPermissionState" -> result.success(getCallPermissionState())
            }
        }
    }

    private fun getWifiIP(): String? {
        try {
            return getWifiAddress()
        } catch (e: Exception) {

        }
        return null
    }

    private fun getWifiAddress(): String? {
        try {

            val en = NetworkInterface.getNetworkInterfaces()
            while (en.hasMoreElements()) {
                val intf = en.nextElement()
                if (intf.name.contains("wl") || intf.name.contains("ap") || intf.name.contains("usb")) {
                    val enumIpAddr: Enumeration<InetAddress> = intf.inetAddresses
                    while (enumIpAddr.hasMoreElements()) {
                        val inetAddress: InetAddress = enumIpAddr.nextElement()
                        if (!inetAddress.isLoopbackAddress && inetAddress.address.size == 4) {
                            return inetAddress.hostAddress
                        }
                    }
                }
            }

        } catch (e: SocketException) {

        }

        return "unknown"
    }

    private fun getInterfacesInfo(): HashMap<String, String> {
        val result = HashMap<String, String>()

        try {
            val en = NetworkInterface.getNetworkInterfaces()
            while (en.hasMoreElements()) {
                val intf = en.nextElement()

                val enumIpAddr: Enumeration<InetAddress> = intf.inetAddresses

                while (enumIpAddr.hasMoreElements()) {
                    val inetAddress: InetAddress = enumIpAddr.nextElement()
                    if (!inetAddress.isLoopbackAddress && inetAddress.address.size == 4) {
                        result[intf.name] = inetAddress.hostAddress
                    }
                }
            }

        } catch (e: SocketException) {

        }

        return result
    }

    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        batteryLevel = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }

    private fun getAndroidName(): String {
        return Build.VERSION.RELEASE;
    }

    private fun callTo(number: String): Boolean {
        return if (getCallPermissionState()) {
            startActivity(Intent(Intent.ACTION_CALL, Uri.parse("tel:${Uri.encode(number)}")))
            true
        } else {
            reqCallPermission()
            false
        }
    }

    private fun getCallPermissionState(): Boolean {
        return (ContextCompat.checkSelfPermission(this, android.Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED)
    }

    private fun reqCallPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(arrayOf(android.Manifest.permission.CALL_PHONE), 0)
        }
    }
}
