import 'package:flutter/material.dart';
import 'dart:async';
import "package:barcode_generator/barcode_generator_flutter.dart";

import 'package:flutter/services.dart';

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
    var barcodeGenerator = BarcodeGenerator(
                    witdth: 300,
                    height: 100,
                    fromString: "9999999",
                    codeType: BarCodeType.kBarcodeFormatDataMatrix,
                  );
                  barcodeGenerator.setText("afsdfsadf");
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Center(
              child: Container(
                  color: Colors.black26,
                  child: barcodeGenerator),
        ),
      ),
    );
  }
}
