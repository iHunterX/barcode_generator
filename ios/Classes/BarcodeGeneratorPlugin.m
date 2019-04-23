#import "BarcodeGeneratorPlugin.h"
#import <barcode_generator/barcode_generator-Swift.h>

@implementation BarcodeGeneratorPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBarcodeGeneratorPlugin registerWithRegistrar:registrar];
}
@end
