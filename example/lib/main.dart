import 'package:flutter/material.dart';
import "package:barcode_generator/barcode_generator_flutter.dart";
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Container(
              color: Colors.black26,
              child: BarcodeGenerator(
                fromString: "9999999",
                codeType: BarCodeType.kBarcodeFormatDataMatrix,
              )),
        ),
      ),
    );
  }
}
