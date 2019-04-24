package com.example.barcode_generator

import android.content.Context;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import io.flutter.plugin.common.StandardMessageCodec


class BarcodeViewFactory(private val messenger: BinaryMessenger) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, o: Any): PlatformView {
        val params = o as Map<String, Any>

        return BarcodeView(context, messenger, id, params)
    }
}
