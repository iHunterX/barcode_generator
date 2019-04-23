//
//  BarcodeImageView.swift
//  barcode_generator
//
//  Created by iHX on 4/19/19.
//

import UIKit
import ZXingObjC
//
//enum ChannelName {
//    static let generateBarcode = "ihx.flutter.io/generatebarcode"
//}

class BarcodeImageView: NSObject, FlutterPlatformView {
    let frame : CGRect
    let viewId : Int64
    let imageView:UIImageView = UIImageView()
    private let messenger: FlutterBinaryMessenger
    
    init(frame:CGRect, viewId:Int64, args: Any?, messenger:FlutterBinaryMessenger){
        self.frame = frame
        self.viewId = viewId
        self.messenger = messenger
        
        super.init()
        NSLog("\n init \(args)")
        let methodChannel = FlutterMethodChannel(name: "ihx.flutter.io/barcode_view_\(viewId)",binaryMessenger: messenger )
        methodChannel.setMethodCallHandler {[unowned self](call: FlutterMethodCall, result: FlutterResult) -> Void  in
            switch call.method {
            case "generateBarcode":
                self.setImage(methodCall: call, result: result)
                break
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
    
    func view() -> UIView {
        imageView.backgroundColor = UIColor.blue
        return imageView
    }
    func setImage(methodCall method:FlutterMethodCall, result : FlutterResult) -> Void {
        NSLog("\n setImage\(method.arguments)")
        guard let args = method.arguments as? [String:Any] else{
            result(FlutterError())
            return
        }
        guard let image = generateImageFromString(arguments: args) else {
            result(FlutterError())
            return
        }
        self.imageView.image = image
        result(nil)
    }
    
    func generateImageFromString(arguments args: Any) -> UIImage?{
        do {
            guard let arg = args as? [String:Any] else { return nil }
            
            guard let barcodeString = arg["fromString"] as? String else { return nil }
            guard let barCodeType = arg["codeType"] as? String else { return nil }
            let barcodeEnum = getZXBarcodeFormat(for: barCodeType)
            let writer = ZXMultiFormatWriter()
            let hints = ZXEncodeHints() as ZXEncodeHints
            let result = try writer.encode(barcodeString, format: barcodeEnum, width: 1000, height: 1000, hints: hints)
            
            if let imageRef = ZXImage.init(matrix: result) {
                if let image = imageRef.cgimage {
                    return UIImage.init(cgImage: image)
                }
            }
        }
        catch {
            print(error)
            return nil
        }
        return nil
    }
    func getZXBarcodeFormat(for string: String) -> ZXBarcodeFormat {
        switch string {
        case StringBarcodeTypeEnum.kBarcodeFormatAztec.rawValue: return kBarcodeFormatAztec
        case StringBarcodeTypeEnum.kBarcodeFormatCodabar.rawValue: return kBarcodeFormatCodabar
        case StringBarcodeTypeEnum.kBarcodeFormatCode39.rawValue: return kBarcodeFormatCode39
        case StringBarcodeTypeEnum.kBarcodeFormatCode93.rawValue: return kBarcodeFormatCode93
        case StringBarcodeTypeEnum.kBarcodeFormatCode128.rawValue: return kBarcodeFormatCode128
        case StringBarcodeTypeEnum.kBarcodeFormatDataMatrix.rawValue: return kBarcodeFormatDataMatrix
        case StringBarcodeTypeEnum.kBarcodeFormatEan13.rawValue: return kBarcodeFormatEan13
        case StringBarcodeTypeEnum.kBarcodeFormatEan8.rawValue: return kBarcodeFormatEan8
        case StringBarcodeTypeEnum.kBarcodeFormatITF.rawValue: return kBarcodeFormatITF
        case StringBarcodeTypeEnum.kBarcodeFormatMaxiCode.rawValue: return kBarcodeFormatMaxiCode
        case StringBarcodeTypeEnum.kBarcodeFormatPDF417.rawValue: return kBarcodeFormatPDF417
        case StringBarcodeTypeEnum.kBarcodeFormatQRCode.rawValue: return kBarcodeFormatQRCode
        case StringBarcodeTypeEnum.kBarcodeFormatRSS14.rawValue: return kBarcodeFormatRSS14
        case StringBarcodeTypeEnum.kBarcodeFormatRSSExpanded.rawValue: return kBarcodeFormatRSSExpanded
        case StringBarcodeTypeEnum.kBarcodeFormatUPCA.rawValue: return kBarcodeFormatUPCA
        case StringBarcodeTypeEnum.kBarcodeFormatUPCE.rawValue: return kBarcodeFormatUPCE
        case StringBarcodeTypeEnum.kBarcodeFormatUPCEANExtension.rawValue: return kBarcodeFormatUPCEANExtension
        default:
            return kBarcodeFormatCode128
        }
    }
    
    public enum StringBarcodeTypeEnum: String {
        /** Aztec 2D barcode format. */
        case kBarcodeFormatAztec = "kBarcodeFormatAztec"
        
        /** CODABAR 1D format. */
        case kBarcodeFormatCodabar = "kBarcodeFormatCodabar"
        
        /** Code 39 1D format. */
        case kBarcodeFormatCode39 = "kBarcodeFormatCode39"
        
        /** Code 93 1D format. */
        case kBarcodeFormatCode93 = "kBarcodeFormatCode93"
        
        /** Code 128 1D format. */
        case kBarcodeFormatCode128 = "kBarcodeFormatCode128"
        
        /** Data Matrix 2D barcode format. */
        case kBarcodeFormatDataMatrix = "kBarcodeFormatDataMatrix"
        
        /** EAN-8 1D format. */
        case kBarcodeFormatEan8 = "kBarcodeFormatEan8"
        
        /** EAN-13 1D format. */
        case kBarcodeFormatEan13 = "kBarcodeFormatEan13"
        
        /** ITF (Interleaved Two of Five) 1D format. */
        case kBarcodeFormatITF = "kBarcodeFormatITF"
        
        /** MaxiCode 2D barcode format. */
        case kBarcodeFormatMaxiCode = "kBarcodeFormatMaxiCode"
        
        /** PDF417 format. */
        case kBarcodeFormatPDF417 = "kBarcodeFormatPDF417"
        
        /** QR Code 2D barcode format. */
        case kBarcodeFormatQRCode = "kBarcodeFormatQRCode"
        
        /** RSS 14 */
        case kBarcodeFormatRSS14 = "kBarcodeFormatRSS14"
        
        /** RSS EXPANDED */
        case kBarcodeFormatRSSExpanded = "kBarcodeFormatRSSExpanded"
        
        /** UPC-A 1D format. */
        case kBarcodeFormatUPCA = "kBarcodeFormatUPCA"
        
        /** UPC-E 1D format. */
        case kBarcodeFormatUPCE = "kBarcodeFormatUPCE"
        
        /** UPC/EAN extension format. Not a stand-alone format. */
        case kBarcodeFormatUPCEANExtension = "kBarcodeFormatUPCEANExtension"
    }
    
}
