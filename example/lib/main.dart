import 'package:flutter/material.dart';
import 'package:barcode_generator/barcode_generator.dart';
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
            width: 500,
            height: 500,
              color: Colors.black26,
              child: BarcodeGenerator(
                backgroundColor: Colors.red,
                fromString: "9999999a",
                codeType: BarCodeType.kBarcodeFormatCode128,
              )),
        ),
      ),
    );
  }
}
