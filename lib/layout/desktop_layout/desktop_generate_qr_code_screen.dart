import 'package:flutter/material.dart';
import 'package:qr_code_generator_v2/utils/qr_logic.dart';
import 'package:qr_code_generator_v2/widgets/color_type_picker_card_widget.dart';
import 'package:qr_code_generator_v2/widgets/padding_and_sizing_card_widget.dart';
import 'package:qr_code_generator_v2/widgets/shape_selector_card_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> with QrCodeLogic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Container(
            color: Colors.grey[900],
            width: 600,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  const Text(
                    "Customize QR Code",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32.0),
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
                  const SizedBox(height: 32.0),
                  ColorTypeSelectorCard(
                    colorType: colorType,
                    color: getColor(),
                    onColorTypeChanged: (ColorType value) {
                      setState(() {
                        colorType = value;
                      });
                    },
                    onColorChanged: (Color value) {
                      setState(() {
                        setColor(value);
                      });
                    },
                  ),
                  const SizedBox(height: 32.0),
                  QrSizePaddingCard(
                    qrSize: qrSize,
                    qrPadding: qrPadding,
                    onSizeChanged: (double value) {
                      setState(() {
                        qrSize = value;
                      });
                    },
                    onPaddingChanged: (double value) {
                      setState(() {
                        qrPadding = EdgeInsets.all(value);
                      });
                    },
                  ),
                  const SizedBox(height: 32.0),
                  ShapeSelectorCard(
                    qrEyeShape: qrEyeShape,
                    qrDotsShape: qrDotsShape,
                    onEyeShapeChanged: (int index) {
                      setState(() {
                        qrEyeShape =
                            index == 0 ? QrEyeShape.square : QrEyeShape.circle;
                      });
                    },
                    onDotsShapeChanged: (int index) {
                      setState(() {
                        qrDotsShape = index == 0
                            ? QrDataModuleShape.square
                            : QrDataModuleShape.circle;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Spacer(),
                  RepaintBoundary(
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
                  const Spacer(),
                ],
              ),
            ),
          )
        ]),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[900],
          onPressed: () {
            setState(() {
              saveQrCode(qrKey, context);
            });
          },
          child: const Icon(Icons.download, color: Colors.white),
        ));
  }
}
