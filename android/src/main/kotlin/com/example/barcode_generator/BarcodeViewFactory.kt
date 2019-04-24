package com.example.barcode_generator

import android.content.Context;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

class TextViewFactory(createArgsCodec: MessageCodec<Any>?, private val messenger: BinaryMessenger) : PlatformViewFactory(createArgsCodec) {
    override fun create(context: Context?, id: Int, args: Any?): PlatformView {
       return FlutterBarcodeView(context,messenger, id)

        //To change body of created functions use File | Settings | File Templates.
    }


}
