package com.example.barcode_generator

import android.content.Context
import android.view.View
import android.widget.ImageView
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.platform.PlatformView
import android.widget.TextView
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

class FlutterBarcodeView(context: Context, messenger: BinaryMessenger, id: Int) : PlatformView, MethodCallHandler {
    private val textView: TextView = TextView(context)
    private val methodChannel: MethodChannel = MethodChannel(messenger, "plugins.felix.angelov/textview_$id")

    init {
        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return textView
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "setText" -> setText(methodCall, result)
            else -> result.notImplemented()
        }

    }

    private fun setText(methodCall: MethodCall, result: Result) {
        val text = methodCall.arguments as String
        textView.text = text
        result.success(null)
    }

    override fun dispose() {}
}