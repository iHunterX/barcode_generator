
part of barcode_generator;

class BarcodeGeneratorController {
  @visibleForTesting
  final MethodChannel channel;

  final _BarcodeGeneratorState _barcodeState;

  BarcodeGeneratorController._(
    this.channel,
    this._barcodeState,
  ) : assert(channel != null) {
    channel.setMethodCallHandler(_handleMethodCall);
  }
  static Future<BarcodeGeneratorController> init(
    int id,
    _BarcodeGeneratorState barcodeState,
  ) async {
    assert(id != null);
    final MethodChannel channel =
        MethodChannel("ihx.flutter.io/barcode_view_$id");
    await channel.invokeMethod('generateBarcode', barcodeState.creationParams);
    return BarcodeGeneratorController._(
      channel,
      barcodeState,
    );
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    // debugPrint(call.method);
    // debugPrint(call.arguments.toString());
    // switch (call.method) {
    //   case 'generatedBarcode':
    //     // if (_barcodeState.widget.onBarcodeGenerated != null) {
    //     //   _barcodeState.widget.onBarcodeGenerated();
    //     // }
    //     break;
    //   default:
    //     throw MissingPluginException();
    // }
  }
}
