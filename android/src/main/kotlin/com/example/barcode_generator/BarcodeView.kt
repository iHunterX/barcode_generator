package com.example.barcode_generator

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.google.zxing.BarcodeFormat
import com.google.zxing.MultiFormatWriter
import com.google.zxing.common.BitMatrix
import com.journeyapps.barcodescanner.BarcodeEncoder
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.platform.PlatformView


class BarcodeView(context: Context, messenger: BinaryMessenger, id: Int, args: Map<String, Any>) : PlatformView, MethodCallHandler {
    private val imageView: ImageView = ImageView(context)
    private val methodChannel: MethodChannel = MethodChannel(messenger, "ihx.flutter.io/barcode_view_$id")
    private val textView:TextView = TextView(context)
    private val argsList:Map<String, Any> = args

    init {
        try {
            if (argsList.containsKey("fromString") && argsList.containsKey("codeType")){
                val string = argsList.get("fromString") as String
                val codeType = argsList.get("codeType") as String
                val barCodeType = getZXBarcodeFormat(codeType)
                generateQR(string,barCodeType)
            }else{
                textView.text = "Wrong Format"
            }
        }catch (e : IllegalArgumentException){
            textView.text = e.stackTrace.toString()
        }


        methodChannel.setMethodCallHandler(this)
    }

    override fun getView(): View {
        return if (textView.text.isEmpty()) {
            imageView
        } else {
            textView
        }
    }

    override fun onMethodCall(methodCall: MethodCall, result: MethodChannel.Result) {
        when (methodCall.method) {
            "generateBarcode" -> handleGenerateBarcode(methodCall.arguments, result)
            else -> result.notImplemented()
        }

    }

    private fun handleGenerateBarcode(args: Any, result: MethodChannel.Result) {
//        val text = args as Any
//        print("handleGenerateBarcode$text")
////        imageView.setBackgroundColor(Color.BLUE)
//        textView.text = text.toString()
        result.success(null)
    }

    override fun dispose() {}

    private fun generateQR(value: String, barcodeFormat:BarcodeFormat = BarcodeFormat.CODE_128){
        val bitMatrix: BitMatrix
        try {
            bitMatrix = MultiFormatWriter().encode(
                    value,
                    barcodeFormat,
                    1000,
                    1000
            )
            val barcodeEncoder = BarcodeEncoder()
            val bitmap = barcodeEncoder.createBitmap(bitMatrix)
            imageView.setImageBitmap(bitmap)
        }catch (e : IllegalArgumentException){
            print(e.stackTrace)
        }

    }


    fun getZXBarcodeFormat(string: String) : BarcodeFormat {
        when (string) {
            StringBarcodeTypeEnum.kBarcodeFormatAztec.rawValue -> return BarcodeFormat.AZTEC
            StringBarcodeTypeEnum.kBarcodeFormatCodabar.rawValue -> return BarcodeFormat.CODABAR
            StringBarcodeTypeEnum.kBarcodeFormatCode39.rawValue -> return BarcodeFormat.CODE_39
            StringBarcodeTypeEnum.kBarcodeFormatCode93.rawValue -> return BarcodeFormat.CODE_93
            StringBarcodeTypeEnum.kBarcodeFormatCode128.rawValue -> return BarcodeFormat.CODE_128
            StringBarcodeTypeEnum.kBarcodeFormatDataMatrix.rawValue -> return BarcodeFormat.DATA_MATRIX
            StringBarcodeTypeEnum.kBarcodeFormatEan13.rawValue -> return BarcodeFormat.EAN_13
            StringBarcodeTypeEnum.kBarcodeFormatEan8.rawValue -> return BarcodeFormat.EAN_8
            StringBarcodeTypeEnum.kBarcodeFormatITF.rawValue -> return BarcodeFormat.ITF
            StringBarcodeTypeEnum.kBarcodeFormatMaxiCode.rawValue -> return BarcodeFormat.MAXICODE
            StringBarcodeTypeEnum.kBarcodeFormatPDF417.rawValue -> return BarcodeFormat.PDF_417
            StringBarcodeTypeEnum.kBarcodeFormatQRCode.rawValue -> return BarcodeFormat.QR_CODE
            StringBarcodeTypeEnum.kBarcodeFormatRSS14.rawValue -> return BarcodeFormat.RSS_14
            StringBarcodeTypeEnum.kBarcodeFormatRSSExpanded.rawValue -> return BarcodeFormat.RSS_EXPANDED
            StringBarcodeTypeEnum.kBarcodeFormatUPCA.rawValue -> return BarcodeFormat.UPC_A
            StringBarcodeTypeEnum.kBarcodeFormatUPCE.rawValue -> return BarcodeFormat.UPC_E
            StringBarcodeTypeEnum.kBarcodeFormatUPCEANExtension.rawValue -> return BarcodeFormat.UPC_EAN_EXTENSION
            else -> return BarcodeFormat.CODE_128
        }
    }
    enum class StringBarcodeTypeEnum(val rawValue: String) {
        /** Aztec 2D barcode format. */
        kBarcodeFormatAztec("kBarcodeFormatAztec"),

        /** CODABAR 1D format. */
        kBarcodeFormatCodabar ("kBarcodeFormatCodabar") ,

        /** Code 39 1D format. */
        kBarcodeFormatCode39 ("kBarcodeFormatCode39") ,

        /** Code 93 1D format. */
        kBarcodeFormatCode93 ("kBarcodeFormatCode93"),

        /** Code 128 1D format. */
        kBarcodeFormatCode128("kBarcodeFormatCode128"),

        /** Data Matrix 2D barcode format. */
        kBarcodeFormatDataMatrix ("kBarcodeFormatDataMatrix"),

        /** EAN-8 1D format. */
        kBarcodeFormatEan8 ("kBarcodeFormatEan8"),

        /** EAN-13 1D format. */
        kBarcodeFormatEan13 ("kBarcodeFormatEan13"),

        /** ITF (Interleaved Two of Five) 1D format. */
        kBarcodeFormatITF ("kBarcodeFormatITF"),

        /** MaxiCode 2D barcode format. */
        kBarcodeFormatMaxiCode ("kBarcodeFormatMaxiCode"),

        /** PDF417 format. */
        kBarcodeFormatPDF417 ("kBarcodeFormatPDF417"),

        /** QR Code 2D barcode format. */
        kBarcodeFormatQRCode ("kBarcodeFormatQRCode"),

        /** RSS 14 */
        kBarcodeFormatRSS14 ("kBarcodeFormatRSS14"),

        /** RSS EXPANDED */
        kBarcodeFormatRSSExpanded ( "kBarcodeFormatRSSExpanded"),

        /** UPC-A 1D format. */
        kBarcodeFormatUPCA ("kBarcodeFormatUPCA"),

        /** UPC-E 1D format. */
        kBarcodeFormatUPCE ("kBarcodeFormatUPCE"),

        /** UPC/EAN extension format. Not a stand-alone format. */
        kBarcodeFormatUPCEANExtension ("kBarcodeFormatUPCEANExtension"),
    }

}