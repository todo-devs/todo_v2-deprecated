package com.cubanopensource.todo

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.widget.RemoteViews

/**
 * Implementation of App Widget functionality.
 */
class TodoAppWidget : AppWidgetProvider() {
    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        // There may be multiple widgets active, so update all of them
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onEnabled(context: Context) {
        // Enter relevant functionality for when the first widget is created
    }

    override fun onDisabled(context: Context) {
        // Enter relevant functionality for when the last widget is disabled
    }
}

internal fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
    // Construct the RemoteViews object
    val views = RemoteViews(context.packageName, R.layout.todo_app_widget)

    val pendingIntentSaldo = PendingIntent.getActivity(context, 0,
            Intent(Intent.ACTION_CALL, Uri.parse("tel:*222${Uri.encode("#")}")), 0)

    val pendingIntentBono = PendingIntent.getActivity(context, 0,
            Intent(Intent.ACTION_CALL, Uri.parse("tel:*222*266${Uri.encode("#")}")), 0)

    val pendingIntentDatos = PendingIntent.getActivity(context, 0,
            Intent(Intent.ACTION_CALL, Uri.parse("tel:*222*328${Uri.encode("#")}")), 0)

    val pendingIntentVoz = PendingIntent.getActivity(context, 0,
            Intent(Intent.ACTION_CALL, Uri.parse("tel:*222*869${Uri.encode("#")}")), 0)

    val pendingIntentSms = PendingIntent.getActivity(context, 0,
            Intent(Intent.ACTION_CALL, Uri.parse("tel:*222*767${Uri.encode("#")}")), 0)

    val pendingIntentTODO = PendingIntent.getActivity(context, 0,
            Intent(context, MainActivity::class.java), 0)

    val pendingIntentWifi = PendingIntent.getActivity(context, 0, Intent(Settings.ACTION_WIFI_SETTINGS), 0)

    val dataUseIntent = Intent(Intent.ACTION_MAIN)
    dataUseIntent.component = (ComponentName(
            "com.android.settings",
            "com.android.settings.Settings\$DataUsageSummaryActivity"
    ))
    dataUseIntent.flags = (Intent.FLAG_ACTIVITY_NEW_TASK and Intent.FLAG_ACTIVITY_CLEAR_TOP)

    val pendingIntentData: PendingIntent

    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P)
        pendingIntentData = PendingIntent.getActivity(context, 0, Intent(Settings.ACTION_DATA_USAGE_SETTINGS), 0)
    else
        pendingIntentData = PendingIntent.getActivity(context, 0, dataUseIntent, 0)

    views.setOnClickPendingIntent(R.id.widget_button_saldo, pendingIntentSaldo)
    views.setOnClickPendingIntent(R.id.widget_button_bonos, pendingIntentBono)
    views.setOnClickPendingIntent(R.id.widget_button_saldo_datos, pendingIntentDatos)
    views.setOnClickPendingIntent(R.id.widget_button_saldo_voz, pendingIntentVoz)
    views.setOnClickPendingIntent(R.id.widget_button_saldo_sms, pendingIntentSms)
    views.setOnClickPendingIntent(R.id.todo_logo, pendingIntentTODO)
    views.setOnClickPendingIntent(R.id.widget_button_net_wifi, pendingIntentWifi)
    views.setOnClickPendingIntent(R.id.widget_button_net_datos, pendingIntentData)

    // Instruct the widget manager to update the widget
    appWidgetManager.updateAppWidget(appWidgetId, views)
}