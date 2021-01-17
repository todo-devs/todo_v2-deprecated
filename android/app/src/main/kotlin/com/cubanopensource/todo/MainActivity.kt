package com.cubanopensource.todo

import android.app.*
import android.content.*
import android.content.pm.*
import android.net.*
import android.os.*
import java.net.*
import java.util.*
import kotlin.collections.*

import android.net.wifi.WifiManager
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import android.graphics.drawable.Icon
import android.provider.Settings
import androidx.annotation.RequiresApi

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.cubanopensource.todo"
    private lateinit var flEngine: FlutterEngine
    lateinit var preferences: SharedPreferences
    lateinit var wifiManager: WifiManager
    lateinit var widgetService : Intent

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        preferences = applicationContext.getSharedPreferences("${packageName}_preferences", Activity.MODE_PRIVATE)
        wifiManager = applicationContext.getSystemService(Context.WIFI_SERVICE) as WifiManager

        widgetService = Intent(this, FloatingWindow::class.java)

        flEngine = flutterEngine

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                //! System info
                "getWifiIp" -> result.success(getWifiIP())
                "getInterfacesInfo" -> result.success(getInterfacesInfo())
                "getBatteryLevel" -> result.success(getBatteryLevel())
                "getAndroidName" -> result.success(getAndroidName())

                //! Call to number
                "callTo" -> result.success(callTo(call.arguments<String>()))
                //! Call permissions handlers
                "callPermissionState" -> result.success(getCallPermissionState())
                "reqCallPermission" -> reqCallPermission()

                //! Overlay permissions handlers
                "getDrawPermissionState" -> result.success(getDrawPermissionState())
                "reqDrawPermission" -> reqDrawPermission()

                //! Show Float Widget
                "setTrueShowWidget" -> setTrueShowWidget()
                "setFalseShowWidget" -> setFalseShowWidget()
                "getShowWidgetPreference" -> result.success(getShowWidgetPreference())
                
                //! Turn on/off wifi
                "turnOnWifi" -> turnOnWifi()
                "turnOffWifi" -> turnOffWifi()
                "isWifiEnabled" -> result.success(isWifiEnabled())
                "getTurnOffWifiPreference" -> result.success(getTurnOffWifiPreference())
                "setTrueTurnOffWifi" -> setTrueTurnOffWifi()
                "setFalseTurnOffWifi" -> setFalseTurnOffWifi()
                
                else -> result.notImplemented()
            }
        }

        if(getDrawPermissionState() && getShowWidgetPreference()) {
            startService(this.widgetService)
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            registerShortcuts()
        }
    }

    //! Turn on/off wifi
    private fun turnOnWifi() {
        wifiManager.isWifiEnabled = true
    }

    private fun turnOffWifi() {
        if (getTurnOffWifiPreference())
            wifiManager.isWifiEnabled = false
    }

    private fun getTurnOffWifiPreference(): Boolean {
        return preferences.getBoolean("turnOffWifi", true)
    }

    private fun isWifiEnabled(): Boolean {
        return wifiManager.isWifiEnabled
    }

    private fun setFalseTurnOffWifi() {
        with(preferences.edit()) {
            putBoolean("turnOffWifi", false)
            apply()
        }
    }

    private fun setTrueTurnOffWifi() {
        with(preferences.edit()) {
            putBoolean("turnOffWifi", true)
            apply()
        }
    }

    //! Show Float Widget
    private fun setTrueShowWidget() {
        if(!getDrawPermissionState()) {
            reqDrawPermission()
        }

        if(getDrawPermissionState()) {
            with(preferences.edit()) {
                putBoolean("showWidget", true)
                apply()
            }

            startService(this.widgetService)
        }
    }

    private fun setFalseShowWidget() {
        with(preferences.edit()) {
            putBoolean("showWidget", false)
            apply()
        }

        // stopService(this.widgetService)
    }

    private fun getShowWidgetPreference(): Boolean {
        return preferences.getBoolean("showWidget", false)
    }

    //! Network info
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
    
    //! Status battery
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

    //! Android name
    private fun getAndroidName(): String {
        return Build.VERSION.RELEASE;
    }

    //! Call to number
    private fun callTo(number: String): Boolean {
        return if (getCallPermissionState()) {
            startActivity(Intent(Intent.ACTION_CALL, Uri.parse("tel:${Uri.encode(number)}")))
            true
        } else {
            reqCallPermission()
            false
        }
    }

    //! Call permissions handlers
    private fun getCallPermissionState(): Boolean {
        return (ContextCompat.checkSelfPermission(this, android.Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED)
    }

    private fun reqCallPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(arrayOf(android.Manifest.permission.CALL_PHONE), 0)
        }
    }

    //! Overlay permissions handlers
    private fun getDrawPermissionState(): Boolean {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M)
            return (Settings.canDrawOverlays(this))

        return true
    }

    private fun reqDrawPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:${packageName}"))
            startActivityForResult(intent, 1)
        }
    }

    //! Register app shortcuts
    @RequiresApi(Build.VERSION_CODES.N_MR1)
    private fun registerShortcuts() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N_MR1) {
            val shortcutManager = getSystemService<ShortcutManager>(ShortcutManager::class.java)

            val saldo = ShortcutInfo.Builder(context, "saldo")
                    .setShortLabel("Saldo")
                    .setLongLabel("Saldo")
                    .setIcon(Icon.createWithResource(context, R.drawable.saldo))
                    .setIntent(Intent(Intent.ACTION_CALL, Uri.parse("tel:*222${Uri.encode("#")}")))
                    .build()

            val bono = ShortcutInfo.Builder(context, "bono")
                    .setShortLabel("Bono")
                    .setLongLabel("Bono")
                    .setIcon(Icon.createWithResource(context, R.drawable.bono))
                    .setIntent(Intent(Intent.ACTION_CALL, Uri.parse("tel:*222*266${Uri.encode("#")}")))
                    .build()

            val datos = ShortcutInfo.Builder(context, "datos")
                    .setShortLabel("Datos")
                    .setLongLabel("Datos")
                    .setIcon(Icon.createWithResource(context, R.drawable.datos))
                    .setIntent(Intent(Intent.ACTION_CALL, Uri.parse("tel:*222*328${Uri.encode("#")}")))
                    .build()

            shortcutManager!!.dynamicShortcuts = Arrays.asList(saldo, bono, datos)
        }
    }
}
