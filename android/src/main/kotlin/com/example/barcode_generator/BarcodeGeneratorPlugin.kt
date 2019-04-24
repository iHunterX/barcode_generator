package com.example.barcode_generator
import io.flutter.plugin.common.PluginRegistry.Registrar

 class BarcodeGeneratorPlugin {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            registrar
                    .platformViewRegistry()
                    .registerViewFactory(
                            "ihx.flutter.io/barcode_view", BarcodeViewFactory(registrar.messenger()))
    }
  }
}

