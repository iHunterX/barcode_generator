import Flutter
import UIKit

public class SwiftBarcodeGeneratorPlugin: NSObject, FlutterPlugin {
    
    
  public static func register(with registrar: FlutterPluginRegistrar) {

    let viewFactory = BarcodeGaneratorFactory.init(messenger: registrar.messenger())
    registrar.register(viewFactory, withId: "ihx.flutter.io/barcode_view")
  }
}
