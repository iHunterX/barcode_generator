//
//  BarcodeGaneratorFactory.swift
//  barcode_generator
//
//  Created by iHX on 4/19/19.
//
import Flutter
import UIKit


class BarcodeGaneratorFactory: NSObject, FlutterPlatformViewFactory {
    private let messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger){
        self.messenger = messenger
        super.init()
        
    }
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        
        return BarcodeImageView(frame: frame, viewId: viewId, args: args, messenger: messenger)
        
    }
}

