part of barcode_generator;

typedef void BarcodeCreatedCallback(BarcodeGeneratorController controller);

class BarcodeGenerator extends StatefulWidget {
  final String fromString;

  final double height;

  final double width;

  final BarCodeType codeType;

  final Color backgroundColor;

  // BarcodeCreatedCallback onBarcodeViewCreated;

  // VoidCallback onBarcodeGenerated;

  const BarcodeGenerator(
      {@required this.fromString,
      this.width = 100,
      this.height = 200,
      this.codeType,
      this.backgroundColor});
  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();

  void setText(String s) {}
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {
  final Completer<BarcodeGeneratorController> _controller =
      Completer<BarcodeGeneratorController>();
  Map<String, dynamic> creationParams;

  @override
  Widget build(BuildContext context) {
    creationParams = <String, dynamic>{
      'fromString': widget.fromString,
      'codeType': widget.codeType.toString().split('.')[1]
    };
    Widget childView;
    if (defaultTargetPlatform == TargetPlatform.android) {
      childView = AndroidView(
        viewType: 'ihx.flutter.io/barcode_view',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      childView = UiKitView(
        viewType: 'ihx.flutter.io/barcode_view',
        onPlatformViewCreated: onPlatformViewCreated,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
        gestureRecognizers: null,
      );
    } else {
      childView = Text(
          '$defaultTargetPlatform is not yet supported by the iHX-Barcode plugin');
    }

    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: childView,
    );
  }

  void onPlatformViewCreated(int id) async {
    final BarcodeGeneratorController controller =
        await BarcodeGeneratorController.init(
      id,
      this,
    );
    _controller.complete(controller);
  }
}
