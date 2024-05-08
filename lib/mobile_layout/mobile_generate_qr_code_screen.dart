import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'dart:html' as html;
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

enum ColorType { qrBackground, cornerEye, dots }

class _MobileLayoutState extends State<MobileLayout> {
  String qrData = "https://dcportfolio.web.app/";
  double qrSize = 200.0;
  EdgeInsets qrPadding = const EdgeInsets.all(8.0);
  Color qrBackgroundColor = Colors.white;
  Color qrCornerEyesColor = Colors.black;
  QrEyeShape qrEyeShape = QrEyeShape.square;
  Color qrDotsColor = Colors.black;
  QrDataModuleShape qrDotsShape = QrDataModuleShape.square;

  ColorType _colorType = ColorType.qrBackground; // Default color type

  TextEditingController qrDataController = TextEditingController();

  final GlobalKey qrKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: RepaintBoundary(
                  key: qrKey,
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: qrSize,
                    padding: qrPadding,
                    backgroundColor: qrBackgroundColor,
                    eyeStyle: QrEyeStyle(
                      eyeShape: qrEyeShape, // Use the qrEyeShape variable
                      color: qrCornerEyesColor,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape:
                          qrDotsShape, // Use the qrDotsShape variable
                      color: qrDotsColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ListView(
                    children: <Widget>[
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: qrDataController,
                            style: const TextStyle(color: Colors.black),
                            decoration: const InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Enter your data",
                              border: InputBorder.none, // Add this line
                            ),
                            onChanged: (value) {
                              setState(() {
                                qrData = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30,
                                child: LayoutBuilder(
                                  builder: (BuildContext context,
                                      BoxConstraints constraints) {
                                    return ToggleButtons(
                                      renderBorder: false,
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.black,
                                      fillColor: Colors.white,
                                      selectedColor: Colors.black,
                                      isSelected: [
                                        _colorType == ColorType.qrBackground,
                                        _colorType == ColorType.cornerEye,
                                        _colorType == ColorType.dots,
                                      ],
                                      onPressed: (int index) {
                                        setState(() {
                                          switch (index) {
                                            case 0:
                                              _colorType =
                                                  ColorType.qrBackground;
                                              break;
                                            case 1:
                                              _colorType = ColorType.cornerEye;
                                              break;
                                            case 2:
                                              _colorType = ColorType.dots;
                                              break;
                                          }
                                        });
                                      },
                                      children: <Widget>[
                                        SizedBox(
                                          width: constraints.maxWidth / 3,
                                          child: const Center(
                                              child: Text("QR Background")),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth / 3,
                                          child: const Center(
                                              child: Text("Corner Eye")),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth / 3,
                                          child:
                                              const Center(child: Text("Dots")),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              ColorPicker(
                                padding: const EdgeInsets.all(0),
                                color: _getColor(),
                                onColorChanged: (Color color) =>
                                    setState(() => _setColor(color)),
                                pickersEnabled: const <ColorPickerType, bool>{
                                  ColorPickerType.wheel:
                                      true, // Enable the wheel picker
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        color: Colors.grey[200],
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "QR Size: ${qrSize.round()}",
                                  ),
                                  Slider(
                                    activeColor: Colors.grey.shade900,
                                    value: qrSize,
                                    min: 100.0,
                                    max: 350,
                                    onChanged: (double value) {
                                      setState(() {
                                        qrSize = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "QR Padding: ${qrPadding.top.round()}",
                                  ),
                                  Slider(
                                    activeColor: Colors.grey.shade900,
                                    value: qrPadding.top,
                                    min: 0.0,
                                    max: 50.0,
                                    onChanged: (double value) {
                                      setState(() {
                                        qrPadding = EdgeInsets.all(value);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  const Text(
                                    "Corner Shape",
                                  ),
                                  ToggleButtons(
                                    selectedColor: Colors.grey.shade900,
                                    isSelected: [
                                      qrEyeShape == QrEyeShape.square,
                                      qrEyeShape == QrEyeShape.circle,
                                    ],
                                    onPressed: (int index) {
                                      setState(() {
                                        qrEyeShape = index == 0
                                            ? QrEyeShape.square
                                            : QrEyeShape.circle;
                                      });
                                    },
                                    children: <Widget>[
                                      Icon(Icons.crop_square,
                                          color: Colors.grey.shade900),
                                      Icon(Icons.radio_button_unchecked,
                                          color: Colors.grey.shade900),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  const Text(
                                    "Dots Shape",
                                  ),
                                  ToggleButtons(
                                    selectedColor: Colors.grey.shade900,
                                    isSelected: [
                                      qrDotsShape == QrDataModuleShape.square,
                                      qrDotsShape == QrDataModuleShape.circle,
                                    ],
                                    onPressed: (int index) {
                                      setState(() {
                                        qrDotsShape = index == 0
                                            ? QrDataModuleShape.square
                                            : QrDataModuleShape.circle;
                                      });
                                    },
                                    children: <Widget>[
                                      Icon(
                                        Icons.crop_square,
                                        color: Colors.grey.shade900,
                                      ),
                                      Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey.shade900,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            setState(() {
              qrData = qrDataController.text;
              saveQrCode(qrKey, context);
            });
          },
          child: Icon(Icons.download, color: Colors.grey[900]),
        ));
  }

  Color _getColor() {
    switch (_colorType) {
      case ColorType.qrBackground:
        return qrBackgroundColor;
      case ColorType.cornerEye:
        return qrCornerEyesColor;
      case ColorType.dots:
        return qrDotsColor;
    }
  }

  void _setColor(Color color) {
    switch (_colorType) {
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
}

Future<void> saveQrCode(GlobalKey qrKey, BuildContext context) async {
  try {
    // Capture the QR code as an image
    RenderRepaintBoundary boundary =
        qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Encode our image to base64
    final base64Image = base64Encode(pngBytes);

    // Create the link with the image data
    final anchor = html.AnchorElement(
      href: 'data:image/png;base64,$base64Image',
    )
      ..setAttribute('download', 'qr_code.png')
      ..click();
  } catch (e) {
print(e);
  }
}
