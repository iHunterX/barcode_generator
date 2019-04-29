# barcode_generator

Barcode generator base on ZXing support multiple fortmats with PlatformView

_Note_: This plugin is still under development, and some APIs might not be available yet. [Feedback welcome](https://github.com/iHunterX/barcode_generator/issues) and [Pull Requests](https://github.com/iHunterX/barcode_generator/pulls) are most welcome!

## Getting Started

Check out the example directory for a sample app using Barcode generator.

```dart
BarcodeGenerator(
            backgroundColor: Colors.red,
            fromString: "xxxxxxx",
            codeType: BarCodeType.kBarcodeFormatCode128,
    )
```

## iOS Integration

Opt-in to the embedded views preview by adding a boolean property to the app's `Info.plist` file with the key `io.flutter.embedded_views_preview` and the value `YES`.

```xml
<key>io.flutter.embedded_views_preview</key>
    <true/>
```

### Features

- [x] Generate barcode with multiple formats
- [x] Supports adjusting the image's dimensions
- [x] No internet connection required
- [ ] Scanning barcode

## Supported Formats

| 1D product | 1D industrial | 2D             |
|:-----------|:--------------|:---------------|
| UPC-A      | Code 39       | QR Code        |
| UPC-E      | Code 93       | Data Matrix    |
| EAN-8      | Code 128      | Aztec (beta)   |
| EAN-13     | Codabar       | PDF 417 (beta) |
|            | ITF           | MaxiCode       |
|            |               | RSS-14         |
|            |               | RSS-Expanded   |


