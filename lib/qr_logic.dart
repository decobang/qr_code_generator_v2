import 'dart:typed_data';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_code_generator_v2/mobile_layout/mobile_generate_qr_code_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum ColorType { qrBackground, cornerEye, dots }

mixin QrCodeLogic<T extends StatefulWidget> on State<T> {
  String qrData = "https://dcportfolio.web.app/";
  double qrSize = 200.0;
  EdgeInsets qrPadding = const EdgeInsets.all(8.0);
  Color qrBackgroundColor = Colors.white;
  Color qrCornerEyesColor = Colors.black;
  QrEyeShape qrEyeShape = QrEyeShape.square;
  Color qrDotsColor = Colors.black;
  QrDataModuleShape qrDotsShape = QrDataModuleShape.square;

  ColorType colorType = ColorType.qrBackground; // Default color type

  TextEditingController qrDataController = TextEditingController();

  final GlobalKey qrKey = GlobalKey();

  Color getColor() {
    switch (colorType) {
      case ColorType.qrBackground:
        return qrBackgroundColor;
      case ColorType.cornerEye:
        return qrCornerEyesColor;
      case ColorType.dots:
        return qrDotsColor;
    }
  }

  void setColor(Color color) {
    switch (colorType) {
      case ColorType.qrBackground:
        qrBackgroundColor = color;
        break;
      case ColorType.cornerEye:
        qrCornerEyesColor = color;
        break;
      case ColorType.dots:
        qrDotsColor = color;
        break;
    }
  }

  Future<void> saveQrCode(GlobalKey qrKey, BuildContext context) async {
    try {
      RenderRepaintBoundary boundary =
          qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage();
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final base64Image = base64Encode(pngBytes);

      final anchor = html.AnchorElement(
        href: 'data:image/png;base64,$base64Image',
      )
        ..setAttribute('download', 'qr_code.png')
        ..click();
    } catch (e) {
      print(e);
    }
  }
}
