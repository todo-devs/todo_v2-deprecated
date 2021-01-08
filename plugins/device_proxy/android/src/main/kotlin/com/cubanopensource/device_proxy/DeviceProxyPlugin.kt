package com.cubanopensource.device_proxy

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import android.app.Activity



class DeviceProxyPlugin(val activity: Activity?) : MethodCallHandler {

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "device_proxy")

      channel.setMethodCallHandler(DeviceProxyPlugin(registrar.activity()))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "getProxySetting" -> {
        result.success("${getProxySetting(this.activity)}")
      }
      else -> {
        result.notImplemented()
      }
    }
  }


  fun getProxySetting(context: Context?): String? {
    try {
      if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.ICE_CREAM_SANDWICH) {
        val proxyAddress = android.net.Proxy.getHost(context)
        if (proxyAddress == null || proxyAddress == "") {
          return proxyAddress
        }
        val port = android.net.Proxy.getPort(context)
        return "$proxyAddress:$port"
      }
      else {
        val address = System.getProperty("http.proxyHost")
        val port = System.getProperty("http.proxyPort")

        if(address.isNotEmpty() && port.isNotEmpty()){
          return "$address:$port"
        }
      }
    } catch (ex: Exception) {
      //ignore
    }

    return ""
  }
}
